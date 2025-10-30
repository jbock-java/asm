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
	movb	$0x44, -21(%rbp)
	movb	$0x41, -48(%rbp)
	movb	$0x42, -47(%rbp)
	movb	$0x43, -46(%rbp)
	movb	$0x12, -45(%rbp)
	mov	$2, %rax
	mov	%rbp, %rsi
	mov	%rbp, %rdi
	sub	$24, %rsi
	sub	$48, %rdi
	strcmp	%rsi, %rdi, $3
	log 	%rax
	mov	$2, %rax
	strcmp	%rdi, %rsi, $3
	log 	%rax
	mov	$2, %rax
	strcmp	%rdi, %rsi, $4
	log 	%rax
	mov	$2, %rax
	strcmp	%rdi, %rsi, $3
	log 	%rax
	call	flush
	call	exit

exit:
	movq	$EXIT, %rax
	movq	$0, %rdi
	syscall
