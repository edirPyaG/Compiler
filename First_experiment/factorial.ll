declare i32 @getint()
declare void @putint(i32 )
declare i32 @getarray(i32*  )
declare void @putarray(i32 ,i32*  )
declare i32 @getch()
declare void @putch(i32 )
declare void @putf(i1*  )
declare void @starttime()
declare void @stoptime()
declare void @memset(i32*  ,i32 ,i32 )
define dso_local i32 @add(i32 %0,i32 %1){
%3 = alloca i32
%4 = alloca i32
store i32 %0, i32*  %4
store i32 %1, i32*  %3
%5 = load i32,i32*  %4
%6 = load i32,i32*  %3
%7 = add  i32 %5,%6
ret i32 %7
}
define dso_local i32 @main(){
%1 = alloca i32
%2 = call i32 @add(i32 1,i32 2)
store i32 %2, i32*  %1
%3 = load i32,i32*  %1
;这一段是添加的代码
%4=alloca i32 
%a=call i32 @getint()
%b=call i32 @getint()
%5= call i32 @add(i32 %a,i32 %b)
call void @putint(i32 %5)
;
call void @putch(i32 10);进行换行
call void @putint(i32 %3)
call void @putch(i32 10);
ret i32 0
}
