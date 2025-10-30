	.data
foo:
	.ascii "abc"
	.text
	.globl main

.include "print_int.s"

main:
	enter
	sub	$48, %rsp
	movb	$0x41, -24(%rbp)
	movb	$0x42, -23(%rbp)
	movb	$0x43, -22(%rbp)
	mov	%rbp, %rsi
	sub	$24, %rsi
	mov	%rsi, %rax
	sub	$24, %rax
	memcpy	%rsi, %rax, $3
	write 	%rax, $3
	call	flush
	call	exit

exit:
	movq	$EXIT, %rax
	movq	$0, %rdi
	syscall
