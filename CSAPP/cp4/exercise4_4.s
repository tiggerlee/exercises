# x-86
rsum:
	testq	%rsi, %rsi
	jle	.L3
	pushq	%rbx
	movq	(%rdi), %rbx
	subq	$1, %rsi
	addq	$8, %rdi
	call	rsum
	addq	%rbx, %rax
	jmp	.L2
.L3:
	movl	$0, %eax
	ret
.L2:
	popq	%rbx
	ret

# y-86
rsum:
	testq	%rsi, %rsi
	jle	.L3
	pushq	%rbx
	movq	(%rdi), %rbx
	irmovq 	$-1, %r8
	addq	%r8, %rsi
	irmovq	$8, %r9 
	addq	%r9, %rdi
	call	rsum
	addq	%rbx, %rax
	jmp	.L2
.L3:
	xorq	%rax, %rax
	ret
.L2:
	popq	%rbx
	ret