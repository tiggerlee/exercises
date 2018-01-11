# 3.23

已知 C 代码如下：

``` c
long dw_loop(long x) {
    long y = x * x;
    long *p = &x;
    long n = 2 * x;
    do {
        x += y;
        (*p)++;
        n--;
    } while (n > 0);
    return x;
}
```

GCC 产生的汇编代码如下：

``` asmble
long dw_loop(long x)
x initially in %rdi
dw_loop:
    movq %rdi, %rax            将 x 复制到 %rax
    movq %rdi, %rcx            将 x 复制到 %rcx
    imulq %rdi, %rcx           计算 y = x * x
    leaq (%rdi,%rdi), %rdx     计算 n = x + x
.L2:
    leaq 1(%rcx,%rax), %rax    计算 x = x + y + 1
    subq $1, %rdx              计算 n -= 1
    testq %rdx, %rdx           判断 n 是不是大于0
    jg .L2                     大于 0 继续循环
    rep; ret                   返回 %rax 中的值
```

A. 哪些寄存器用来存放 x、y 和 n？ x in %rax, y in %rcx, n in %rdx
B. 编译器如何消除对指针变量 p 和表达式 (*p)++ 隐含的指针间接引用的需求？ 因为指针 p 总是指向 x，所以编译器使用 leaq 将 x = x + y + 1 合并为 leaq 1(%rcx, %rax), %rax 一条指令
C. 给汇编代码添加注释，解释如何实现。