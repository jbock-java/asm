	.text
	.globl	_start
_start:
	pushq	%rbp
	movq	%rsp, %rbp
	movb	$48, -11(%rbp)
	movb	$120, -10(%rbp)
	movb	$100, -9(%rbp)
	movb	$101, -8(%rbp)
	movb	$97, -7(%rbp)
	movb	$100, -6(%rbp)
	movb	$98, -5(%rbp)
	movb	$101, -4(%rbp)
	movb	$101, -3(%rbp)
	movb	$102, -2(%rbp)
	movb	$10, -1(%rbp)
	mov	$11, %rdx
	leaq	-11(%rbp), %rsi
	mov	$1, %rdi
	mov	$1, %rax
	syscall
	jmp	exit

exit:
	movq	$60, %rax
	movq	$0, %rdi
	syscall
