	.text
	.globl main

.include "../print_int/print_int.s"

print_char:					# debugging
	frame_enter
	sys_enter
	push	%rax
	push	%rcx
	push	%rdx
	push	%rsi
	push	%rdi
	mov	16(%rbp), %rax
	movb	$0x3e, -128(%rbp)
	movb	%al, -127(%rbp)
	movb	$0x3c, -126(%rbp)
	movb	$0xa, -125(%rbp)
	lea	-128(%rbp), %rsi
	mov	$WRITE, %rax
	mov	$STDOUT, %rdi
	mov	$4, %rdx
	syscall
	pop	%rdi
	pop	%rsi
	pop	%rdx
	pop	%rcx
	pop	%rax
	sys_leave
	frame_leave
	ret

main:
	mov	$0x9084, %rax
	shl	$16, %rax
	add	$0xa412, %rax
	push	%rax
	call	print_int
	jmp	exit

exit:
	movq	$EXIT, %rax
	movq	$0, %rdi
	syscall
