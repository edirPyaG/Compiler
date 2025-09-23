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
define dso_local i32 @main(){
call void @putint(i32 12345)
call void @putch(i32 65)
ret i32 0
}
