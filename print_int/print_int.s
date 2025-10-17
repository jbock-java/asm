#https://www.youtube.com/watch?v=_hbZN4khAyU
#https://github.com/xmdi/SCHIZONE
	.equ	STDOUT, 1
	.equ	WRITE, 1
	.equ	EXIT, 60

	.macro enter
	push	%rbp
	mov	%rsp, %rbp
	.endm

	.macro return
	mov	%rbp, %rsp
	pop	%rbp
	ret
	.endm

	.macro push_all
	push	%rbx
	push	%rcx
	push	%r8
	push	%r9
	push	%r10
	push	%r11
	push	%rdi
	push	%rdx
	.endm

	.macro pop_all
	pop	%rdx
	pop	%rdi
	pop	%r11
	pop	%r10
	pop	%r9
	pop	%r8
	pop	%rcx
	pop	%rbx
	.endm

	.text
	.globl main

write_char_debug:
	enter
	push_all
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
	pop_all
	return

write_char:
	enter
	push_all
	mov	16(%rbp), %rax
	movb	%al, -64(%rbp)
	lea	-64(%rbp), %rsi
	mov	$WRITE, %rax
	mov	$STDOUT, %rdi
	mov	$1, %rdx
	syscall
	pop_all
	return

write_newline:
	enter
	push_all
	push	$0xa
	call	write_char
	pop	%rax
	pop_all
	return

write_string:
	enter
	push_all
	mov	24(%rbp), %rsi			# param: address
	mov	16(%rbp), %rdx			# param: size
	mov	$WRITE, %rax
	mov	$STDOUT, %rdi
	syscall
	pop_all
	return

print_int:
	enter

	mov	16(%rbp), %rsi			# param: number to print

	sub	$48, %rsp
	push_all

	mov	$0, %rcx

print_int_push_loop:
	mov	%rsi, %rax
	and	$0xf, %rax
	add	$0x30, %rax			# %rax now contains ascii "0"-"9"
	cmp	$0x39, %rax
	jle	print_int_after_adjust
	add	$39, %rax			# adjust for ascii "a"-"f"
print_int_after_adjust:
	movb	%al, -24(%rbp, %rcx)
	inc	%rcx
	shr	$4, %rsi
	test	%rsi, %rsi
	jnz	print_int_push_loop

	mov	$0, %rdx

	movb	$0x30, -48(%rbp, %rdx)
	inc	%rdx
	movb	$0x78, -48(%rbp, %rdx)
	inc	%rdx

print_int_pop_loop:
	dec	%rcx
	mov	-24(%rbp, %rcx), %rax
	movb	%al, -48(%rbp, %rdx)
	inc	%rdx
	test	%rcx, %rcx
	jnz	print_int_pop_loop

	movb	$0xa, -48(%rbp, %rdx)
	inc	%rdx

	lea	-48(%rbp), %rsi
	push	%rsi
	push	%rdx
	call	write_string
	pop	%rdx
	pop	%rsi

	pop_all
	return

