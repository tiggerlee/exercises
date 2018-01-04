# 3.6

假设寄存器 %rax 的值为 x，%rcx 的值为 y，填写下表，指明下面每条汇编代码指令存储在寄存器 %rdx 中的值：

表达式                      | 结果
---------------------------|--------------
leaq 6(%rax), %rdx         |x+6
leaq (%rax,%rcx), %rdx     |x+y
leaq (%rax,%rcx,4), %rdx   |x+4y
leaq 7(%rax,%rax,8), %rdx  |7+9x
leaq 0xA(,%rcx,4), %rdx    |10+4y
leaq 9(%rax,%rcx,2), %rdx  |9+x+2y