/*#include <stdio.h>

unsigned long long factorial(int n) {
    unsigned long long result = 1;
    for (int i = 1; i <= n; i++) {
        result *= i;
    }
    return result;
}

int main() {
    int n;
    printf("请输入一个正整数: ");
    scanf("%d", &n);
    
    if (n < 0) {
        printf("无法计算负数的阶乘\n");
    } else {
        printf("%d! = %llu\n", n, factorial(n));
    }
    
    return 0;
}*/

.global _start
.text
_start:
    //计算5的阶乘
    mov x0,5
    mov x1,1 //初始化
    mov x2,1 //计数器
factorial_loop:
    cmp x2,x0
    bgt factprial_done //bgt的缩写是branch if greater than
    mul x1,x1,x2 //x1 = x1 * x2
    add x2,x2,1 //x2++
    b factorial_loop  //b的缩写是branch
factprial_done:
    //退出程序
    mov x0,x1 //返回值
    mov x8,93 //系统调用号，93是exit x8指的是系统调用号寄存器，作用是告诉操作系统我们要调用哪个系统调用
    svc 0 //触发系统调用 svc的缩写是supervisor call，中文叫做超级用户调用
