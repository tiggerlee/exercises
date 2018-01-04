# 练习3.4

假设变量 sp 和 dp 被声明为类型

``` c
src_t *sp;
dest_t *sp;
```

src_t 和 dest_t 是用 typedef 声明的数据类型，使用适当的数据传送指令实现操作`*dp = (dest_t) *sp;`。

src_t   | dest_t  | 指令
--------|---------|---------
long    |long     | movq (%rdi), %rax; movq %rax, (%rsi)
char    |int      | movsbl (%rdi), %eax; movl %eax, (%rsi)
char    |unsigned | movsbl (%rdi), %eax; movl %eax, (%rsi)
unsigned char     |long | movzbl (%rdi), %eax; movq %rax, (%rsi)
int     |char     | movl (%rdi), %eax; movb %al, (%rsi)
unsigned|unsigned char | movl (%rdi), %eax; movb %al, (%rsi)
char    |short    | movsbw (%rdi), %ax; movw %ax, (%rsi)