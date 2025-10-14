	.text
	.globl	_start
_start:
	pushq	%rbp
	movq	%rsp, %rbp
	mov	$0, %rcx
	movb	$0x30, -11(%rbp, %rcx)		# "0"
	inc	%rcx
	movb	$0x78, -11(%rbp, %rcx)		# "x"
	inc	%rcx
	movb	$0x64, -11(%rbp, %rcx)		# "d"
	inc	%rcx
	movb	$0x65, -11(%rbp, %rcx)		# "e"
	inc	%rcx
	movb	$0x61, -11(%rbp, %rcx)		# "a"
	inc	%rcx
	movb	$0x64, -11(%rbp, %rcx)		# "d"
	inc	%rcx
	movb	$0x62, -11(%rbp, %rcx)		# "b"
	inc	%rcx
	movb	$0x65, -11(%rbp, %rcx)		# "e"
	inc	%rcx
	movb	$0x65, -11(%rbp, %rcx)		# "e"
	inc	%rcx
	movb	$0x66, -11(%rbp, %rcx)		# "f"
	inc	%rcx
	movb	$0xa, -11(%rbp, %rcx)
	inc	%rcx
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
