	.file	"draft.c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB23:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	i(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, i(%rip)
	movslq	%eax, %rdx
	movb	$48, -5(%rbp,%rdx)
	leal	2(%rax), %edx
	movl	%edx, i(%rip)
	movslq	%ecx, %rcx
	movb	$120, -5(%rbp,%rcx)
	leal	3(%rax), %ecx
	movl	%ecx, i(%rip)
	movslq	%edx, %rdx
	movb	$52, -5(%rbp,%rdx)
	leal	4(%rax), %edx
	movl	%edx, i(%rip)
	movslq	%ecx, %rcx
	movb	$49, -5(%rbp,%rcx)
	addl	$5, %eax
	movl	%eax, i(%rip)
	movslq	%edx, %rdx
	movb	$10, -5(%rbp,%rdx)
	leaq	-5(%rbp), %rdx
	movl	$5, %ecx
	movl	$1, %esi
	movl	$1, %edi
	movl	$0, %eax
	call	syscall@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	main, .-main
	.globl	i
	.bss
	.align 4
	.type	i, @object
	.size	i, 4
i:
	.zero	4
	.globl	fh
	.align 4
	.type	fh, @object
	.size	fh, 4
fh:
	.zero	4
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
