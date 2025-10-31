#include <sys/syscall.h>
	.text
	.globl main

.include "print_int.s"

main:
	mov	$0x9084, %rax
	shl	$16, %rax
	add	$0xa412, %rax

	mov	$1, %rbx
	mov	$2, %rcx
	mov	$3, %r8
	mov	$4, %r9
	mov	$5, %r10
	mov	$6, %r11
	mov	$7, %rdi
	mov	$8, %rdx
	mov	$9, %rsi

	log	%rax
	log	%rbx
	log	%rcx
	log	%r8
	log	%r9
	log	%r10
	log	%r11
	log	%rdi
	log	%rdx
	log	%rsi

	log	%rax
	log	%rbx
	log	%rcx
	log	%r8
	log	%r9
	log	%r10
	log	%r11
	log	%rdi
	log	%rdx
	log	%rsi

	call	flush
	call	exit

exit:
	mov	$SYS_exit_group, %rax
	mov	$0, %rdi
	syscall
