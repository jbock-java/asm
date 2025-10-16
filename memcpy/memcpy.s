	.file	"draft.c"
	.text
	.globl	get_zero
	.type	get_zero, @function
get_zero:
.LFB23:
	.cfi_startproc
	movl	$128, %edx
.L2:
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %edx
	cmpl	$16, %eax
	jne	.L2
	movl	$0, %eax
	ret
	.cfi_endproc
.LFE23:
	.size	get_zero, .-get_zero
	.globl	get_one
	.type	get_one, @function
get_one:
.LFB24:
	.cfi_startproc
	movl	$128, %edx
.L4:
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %edx
	cmpl	$8, %eax
	jne	.L4
	movl	$1, %eax
	ret
	.cfi_endproc
.LFE24:
	.size	get_one, .-get_one
	.globl	get_two
	.type	get_two, @function
get_two:
.LFB25:
	.cfi_startproc
	movl	$128, %edx
.L6:
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %edx
	cmpl	$4, %eax
	jne	.L6
	movl	$2, %eax
	ret
	.cfi_endproc
.LFE25:
	.size	get_two, .-get_two
	.globl	get_three
	.type	get_three, @function
get_three:
.LFB26:
	.cfi_startproc
	movl	$128, %edx
.L8:
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %edx
	cmpl	$32, %eax
	jne	.L8
	movl	$3, %eax
	ret
	.cfi_endproc
.LFE26:
	.size	get_three, .-get_three
	.globl	main
	.type	main, @function
main:
.LFB27:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$8, %rsp
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	movl	$4, %edi
	call	malloc@PLT
	movq	%rax, %rbx
	movq	%rax, in(%rip)
	movl	$4, %edi
	call	malloc@PLT
	movq	%rax, out(%rip)
	movb	$48, (%rbx)
	movq	in(%rip), %rax
	movb	$120, 1(%rax)
	movq	in(%rip), %rax
	movb	$97, 2(%rax)
	movq	in(%rip), %rax
	movb	$10, 3(%rax)
	movl	$0, %r13d
	movl	$1, %r12d
	movl	$2, %ebx
	movl	$3, %eax
	movslq	%r13d, %rdx
	movq	%rdx, %rcx
	add	out(%rip), %rcx
	movq	in(%rip), %rsi
	movzbl	(%rsi,%rdx), %edx
	movb	%dl, (%rcx)
	movslq	%r12d, %rdx
	movq	%rdx, %rcx
	add	out(%rip), %rcx
	movq	in(%rip), %rsi
	movzbl	(%rsi,%rdx), %edx
	movb	%dl, (%rcx)
	movslq	%ebx, %rdx
	movq	%rdx, %rcx
	add	out(%rip), %rcx
	movq	in(%rip), %rsi
	movzbl	(%rsi,%rdx), %edx
	movb	%dl, (%rcx)
	cltq
	movq	%rax, %rdx
	add	out(%rip), %rdx
	movq	in(%rip), %rcx
	movzbl	(%rcx,%rax), %eax
	movb	%al, (%rdx)
	movl	$4, %ecx
	mov	out(%rip), %rdx
	movl	$1, %esi
	movl	$1, %edi
	movl	$0, %eax
	call	syscall@PLT
	movl	$0, %eax
	add	$8, %rsp
	pop	%rbx
	pop	%r12
	pop	%r13
	pop	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.size	main, .-main
	.globl	out
	.bss
	.align 8
	.type	out, @object
	.size	out, 8
out:
	.zero	8
	.globl	in
	.align 8
	.type	in, @object
	.size	in, 8
in:
	.zero	8
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
