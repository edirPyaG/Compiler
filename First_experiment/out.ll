; -- 首先，声明你需要用到的外部函数 --
declare void @putch(i32)
; (这里也列出其他的，虽然这个例子只用到了 putch)
declare i32 @getint()
declare void @putint(i32)
declare i32 @getarray(i32*)
declare void @putarray(i32, i32*)
declare i32 @getch()
declare void @starttime()
declare void @stoptime()
declare void @memset(i32*, i32, i32)

; -- 1. 定义字符串常量 (这就是你说的“字串数组”) --
; "请你输入一个数字" -> 7个汉字 * 3字节/汉字 = 21字节
; 加上字符串末尾的空字符 '\0'，总共是 22 字节。
@.str = private unnamed_addr constant [25 x i8] c"请你输入一个数字\00"

; -- 定义一个专门用来打印这个提示语的函数 --
define void @print_prompt() {
entry:
  ; 我们将使用一个循环来遍历字符串。
  ; 首先无条件跳转到循环的条件检查部分。
  br label %loop_condition

loop_condition:
  ; phi 节点用于在循环中追踪我们的索引（相当于C代码里的 i）。
  ; 第一次进入循环时(从 entry 标签来)，索引 i 的值为 0。
  ; 之后每次循环时(从 loop_body 标签来)，索引的值为上一次更新后的 %i.next。
  %i = phi i32 [ 0, %entry ], [ %i.next, %loop_body ]

  ; 计算字符串中第 i 个字节的地址
  ; GEP (GetElementPtr) 是 LLVM 中用于地址计算的核心指令
  %char_ptr = getelementptr inbounds [22 x i8], ptr @.str, i32 0, i32 %i

  ; 从计算出的地址加载一个字节 (i8) 的内容
  %char_byte = load i8, ptr %char_ptr

  ; 检查加载的字节是否是字符串结束符 '\0' (ASCII 值为 0)
  %is_end = icmp eq i8 %char_byte, 0

  ; 如果是结束符，就跳转到 loop_exit 退出循环；否则，进入循环体 loop_body
  br i1 %is_end, label %loop_exit, label %loop_body

loop_body:
  ; 我们已经加载了字节 %char_byte (类型是 i8)
  ; putch 函数需要一个 i32 类型的参数，所以我们需要进行类型扩展。
  ; zext (zero-extend) 将 i8 无符号扩展到 i32。
  %char_for_putch = zext i8 %char_byte to i32
  
  ; 调用 putch 函数打印这个字节（字符）
  call void @putch(i32 %char_for_putch)

  ; 计算下一个索引 (i = i + 1)
  %i.next = add nsw i32 %i, 1

  ; 无条件跳转回循环的条件检查部分，进行下一次循环
  br label %loop_condition

loop_exit:
  ; 循环结束，从函数返回
  ret void
}

; -- 示例: 在一个 main 函数中调用这个打印函数 --
define i32 @main() {
entry:
  ; 调用我们自己写的函数来打印提示语
  call void @print_prompt()
  
  ; 之后可以继续执行你的其他逻辑，例如获取用户输入
  %val = call i32 @getint()
  call void @putint(i32 %val)
  
  ret i32 0
}