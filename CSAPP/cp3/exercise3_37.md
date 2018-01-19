# exercise 3.37

表达式        | 类型            | 值              | 汇编代码
-------------|-----------------|-----------------|-------------------
S+1          | short*          | Xs + 2          | leaq 2(%rdx), %rax
S[3]         | short           | M[Xs+6]         | movw 6(%rdx), %ax
&S[i]        | short*          | Xs + 2i         | leaq (%rdx,%rcx,2), %rax
S[4*i+1]     | short           | M[Xs+8i+2]      | movw 2(%rdx,%rcx,8), %ax
S+i-5        | short*          | Xs+2i-10        | leaq -10(%rdx,%rcx,2), %rax