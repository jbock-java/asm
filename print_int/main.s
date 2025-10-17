	.text
	.globl main

.include "print_int.s"

basic_method:
	enter
	sub	$144, %rsp
	push_all
	mov	16(%rbp), %rsi
	mov	$0, %rcx
	pop_all
	return

main:
	mov	$0x9084, %rax
	shl	$16, %rax
	add	$0xa412, %rax
	push	%rax
	call	print_int

exit:
	movq	$EXIT, %rax
	movq	$0, %rdi
	syscall
