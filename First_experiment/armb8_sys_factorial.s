/*
#include <stdio.h>

long long factorial(int n) {
    long long result = 1;
    for (int i = 1; i <= n; i++) {
        result *= i;
    }
    return result;
}

int main() {
    int n;
    printf("请输入一个整数: ");
    scanf("%d", &n);

    printf("%d! = %lld\n", n, factorial(n));
    return 0;
}
 */

.global main
.global factorial
.extern printf //extern表示这个函数在别的文件中定义,中文翻译是外部的意思，调用的是C标准库的printf函数
.extern scanf  //调用的是C标准库的scanf函数，scanf是用来从标准输入读取格式化输入的函数

.data //.data段是用来存放初始化的全局变量和静态变量的
fmt_input: .asciz "请输入一个整数: \n" /*fmt_input是一个标签，.asciz表示这个字符串是以null结尾的,这个字符串是已经初始化的*/
fmt_output: .asciz "%d! = %lld\n" //输出格式化字符串
fmt_read: .asciz "%d" //输入格式化字符串,asciz的是ASCII zero terminated的意思，表示以null结尾的字符串

var_n: .word 0 //定义一个整型变量_n，并初始化为0，.word表示这个变量占4个字节
.text //.text段是用来存放代码的

factorial: //定义一个函数factorial
    //函数参数n通过x0传递
    //返回值通过x0传递
    mov x1, 1 //初始化result为1，x1用来存放result
    mov x2, 1 //初始化计数器i为1，x2用来存放i

loop:
    cmp x2, x0 //比较i和n
    bgt end_loop //如果i > n，跳转到end_loop
    mul x1, x1, x2 //result *= i
    add x2, x2, 1 //i++
    b loop //跳回loop
end_loop:
    mov x0, x1 //将result放到x0中作为返回值
    ret //返回,ret是return的缩写

main:
    
    adr x0, fmt_input //将fmt_input的地址加载到x0中，adr是load address的缩写,将它的地址加载到寄存器0的目的是为了调用printf函数默认会把x0作为第一个参数传递
    bl printf //调用printf函数，bl是branch with link的缩写，表示跳转到某个地址并将返回地址存储在链接寄存器x30中
    adr x0, fmt_read //将fmt_read的地址加载到x0中
    adr x1, var_n //将var_n的地址加载到x1中
    bl scanf //调用scanf函数，从标准输入读取一个整数并存储在var_n
    ldr w0, [x1] //将var_n的值加载到w0中，w0是x0的低32位，x寄存器是64位的，w寄存器是32位的
    bl factorial //调用factorial函数，计算阶乘，结果保存在x0中

    mov x2, x0 // 将阶乘结果从x0移动到x2中，作为printf的第三个参数
    //打印结果
    adr x0, fmt_output //将fmt_output的地址加载到x0中
    ldr w1, [x1] // 将var_n的值加载到w1，作为printf的第二个参数
    bl printf //调用printf函数，打印结果
    //退出程序
    mov x0, 0 //返回值0
    mov x8, 93 //系统调用号，93是exit
    svc 0 //触发系统调用



