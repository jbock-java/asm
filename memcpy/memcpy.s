	.bss
out:
	.zero	8
in:
	.zero	8

	.text
	.globl	main

main:
	push	%rbp
	mov	%rsp, %rbp
	push	%r13
	push	%r12
	push	%rbx
	sub	$8, %rsp
	mov	$4, %rdi
	call	malloc@PLT
	mov	%rax, %rbx
	mov	%rax, in(%rip)
	mov	$4, %rdi
	call	malloc@PLT
	mov	%rax, out(%rip)
	movb	$48, (%rbx)
	mov	in(%rip), %rax
	movb	$120, 1(%rax)
	mov	in(%rip), %rax
	movb	$97, 2(%rax)
	mov	in(%rip), %rax
	movb	$10, 3(%rax)
	mov	$3, %rax
	mov	$0, %rdx
	mov	$0, %rcx
	add	out(%rip), %rcx
	mov	in(%rip), %rsi
	mov	(%rsi, %rdx), %rdx
	movb	%dl, (%rcx)
	mov	$1, %rdx
	mov	%rdx, %rcx
	add	out(%rip), %rcx
	mov	(%rsi, %rdx), %rdx
	movb	%dl, (%rcx)
	mov	$2, %rdx
	mov	%rdx, %rcx
	add	out(%rip), %rcx
	mov	(%rsi, %rdx), %rdx
	movb	%dl, (%rcx)
	mov	$3, %rdx
	add	out(%rip), %rdx
	mov	in(%rip), %rcx
	mov	(%rcx, %rax), %rax
	movb	%al, (%rdx)
	mov	$4, %rcx
	mov	out(%rip), %rdx
	mov	$1, %rsi
	mov	$1, %rdi
	mov	$0, %rax
	call	syscall@PLT
	mov	$0, %rax
	add	$8, %rsp
	pop	%rbx
	pop	%r12
	pop	%r13
	pop	%rbp
	ret
