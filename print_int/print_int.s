#https://www.youtube.com/watch?v=_hbZN4khAyU
#https://github.com/xmdi/SCHIZONE
	.equ	STDOUT, 1
	.equ	WRITE, 1
	.equ	EXIT, 60

	.macro sys_enter
	push	%rcx
	push	%r11
	.endm

	.macro sys_leave
	pop	%r11
	pop	%rcx
	.endm

	.macro frame_enter
	push	%rbp
	mov	%rsp, %rbp
	.endm

	.macro frame_leave
	mov	%rbp, %rsp
	pop	%rbp
	.endm

	.macro enter
	push	%rbp
	mov	%rsp, %rbp
	push	%rcx
	push	%r8
	push	%r9
	push	%r10
	push	%r11
	push	%rdi
	push	%rdx
	.endm

	.macro return
	pop	%rdx
	pop	%rdi
	pop	%r11
	pop	%r10
	pop	%r9
	pop	%r8
	pop	%rcx
	mov	%rbp, %rsp
	pop	%rbp
	ret
	.endm

	.text
	.globl main

write_char_debug:
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

write_char:
	enter
	push	%rax
	push	%rcx
	push	%rdx
	push	%rsi
	push	%rdi
	mov	16(%rbp), %rax
	movb	%al, -64(%rbp)
	lea	-64(%rbp), %rsi
	mov	$WRITE, %rax
	mov	$STDOUT, %rdi
	mov	$1, %rdx
	syscall
	pop	%rdi
	pop	%rsi
	pop	%rdx
	pop	%rcx
	pop	%rax
	return

write_newline:
	mov	%rsp, %rbp
	push	$0xa
	call	write_char
	mov	%rbp, %rsp
	ret

write_string:
	enter
	mov	24(%rbp), %rsi		# param: address
	mov	16(%rbp), %rdx		# param: size
	mov	$WRITE, %rax
	mov	$STDOUT, %rdi
	syscall
	return

print_int:
	frame_enter
	sub	$128, %rsp

	push	%rax
	push	%rsi
	push	%rdx
	push	%rcx
	push	%rdi

	mov	16(%rbp), %rsi
	mov	$0, %rcx

print_int_push_loop:
	mov	%rsi, %rax
	and	$0xf, %rax
	add	$0x30, %rax			# %rax now contains ascii "0"-"9"
	cmp	$0x39, %rax
	jle	print_int_after_adjust
	add	$39, %rax			# adjust for ascii "a"-"f"
print_int_after_adjust:
	movb	%al, -64(%rbp, %rcx)
	inc	%rcx
	shr	$4, %rsi
	test	%rsi, %rsi
	jnz	print_int_push_loop

	mov	$0, %rdx

	movb	$0x30, -96(%rbp, %rdx)
	inc	%rdx
	movb	$0x78, -96(%rbp, %rdx)
	inc	%rdx

print_int_pop_loop:
	dec	%rcx
	mov	-64(%rbp, %rcx), %rax
	movb	%al, -96(%rbp, %rdx)
	inc	%rdx
	test	%rcx, %rcx
	jnz	print_int_pop_loop

	movb	$0xa, -96(%rbp, %rdx)
	inc	%rdx

	lea	-96(%rbp), %rsi
	push	%rsi
	push	%rdx
	call	write_string
	pop	%rdx
	pop	%rsi

	pop	%rdi
	pop	%rcx
	pop	%rdx
	pop	%rsi
	pop	%rax

	frame_leave

	ret
