# exercise 3.43

``` c
typedef union {
    struct {
        long u;
        short v;
        char w;
    } t1;
    struct {
        int a[2];
        char *p;
    } t2;
} u_type;

void get(u_type *up, type *dest) {
    *dest = expr;
}
```

up in %rdi, dest in %rsi

expr       | type      | 代码
-----------|-----------|--------------------
up->t1.u   | long      | movq (%rdi), %rax; movq %rax, (%rsi)
up->t1.v   | short     | movw 8(%rdi), %ax; movw %ax, (%rsi)
&up->t1.w  | char*     | leaq 16(%rdi), %rax; movq %rax, (%rsi)
up->t2.a   | int*      | movq %rdi, %rsi
up->t2.a[up->t1.u] | int | movq (%rdi), %rax; movl (%rdi,%rax,4), %eax; movl %eax, (%rsi)
*up->t2.p  | char      | movb 8(%rdi), %al; movb %al, (%rsi)