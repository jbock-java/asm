	.text
	.globl main

.include "../print_int/print_int.s"

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
