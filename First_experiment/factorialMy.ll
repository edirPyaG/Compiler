;导入外部函数
;这个算法用来计算阶乘
declare i32 @getint()
declare void @putint(i32)
declare void @putch(i32)


;定义主函数
define dso_local i32 @main(){
    %n=alloca i32
    %1=call i32 @getint()
    store i32 %1, i32* %n;获得n的值并进行堆存储
    %i=alloca i32;分配for循环变量i的空间
    store i32 1,i32* %i;初始化为i=1
    %result=alloca i32;分配结果result的空间
    store i32 1, i32* %result;初始化result=1
    br label %fact
    ;添加一个label,进行for循环
    fact:
        %reValue=load i32,i32* %result
        %iValue=load i32 ,i32* %i
        %nValue=load i32 , i32* %n
        %cmp=icmp ugt i32 %iValue,%nValue;比较i和n的大小
        br i1 %cmp, label %final ,label %body;如果i>n,则跳转到final,否则跳转到fact

    body:
        %newValue=mul i32 %reValue,%iValue;计算result=result*i(i的编址从1开始)
        store i32 %newValue ,i32* %result;将结果存入result
        ;i=i+1
        %newiValue=add i32 %iValue ,1
        store i32 %newiValue,i32* %i
        br label %fact    
    ;fianl
    final:
        %fiValue=load i32 ,i32* %result;加载最后的结果
        call void @putint(i32 %fiValue);输出结果
        call void @putch(i32 10);进行换行
        ret i32 0;
}




