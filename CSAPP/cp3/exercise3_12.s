uremdiv:
    movq %rdx, %r8
    movq %rdi, %rax
	movl $0, %edx
    divq %rsi
    movq %rax, (%r8)
    movq %rdx, (%rcx)