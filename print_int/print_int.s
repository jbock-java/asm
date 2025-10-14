#https://www.youtube.com/watch?v=_hbZN4khAyU
#https://github.com/xmdi/SCHIZONE
	.equ	STDOUT, 1
	.equ	WRITE, 1
	.equ	EXIT, 60

	.data

	.text
	.globl main

# char rdi
print_char:
	push	%rbp
	mov	%rsp, %rbp
	push	%rax
	push	%rcx
	push	%rdx
	push	%rsi
	push	%rdi
	mov	$WRITE, %rax
	mov	%rdi, -128(%rbp)
	lea	-128(%rbp), %rsi
	mov	$STDOUT, %rdi
	mov	$1, %rdx
	syscall
	pop	%rdi
	pop	%rsi
	pop	%rdx
	pop	%rcx
	pop	%rax
	mov	%rbp, %rsp
	pop	%rbp
	ret

# char *rsi, int rdx
write_string:
	mov	$WRITE, %rax
	mov	$STDOUT, %rdi
	syscall
	ret

# int rsi
print_int:
	push	%rax
	push	%rbp
	push	%rsi
	push	%rdx
	push	%rcx
	push	%rdi
	mov	%rsp, %rbp 	# save stack pointer

	mov	$0, %rcx

print_int_push_loop:
	mov	%rsi, %rax
	and	$0xf, %rax
	add	$0x30, %rax	# %rax now contains ascii "0"-"9"
	cmp	$0x39, %rax
	jle	print_int_after_adjust
	add	$39, %rax	# adjust for ascii "a"-"f"
print_int_after_adjust:
	#movb	%al, -64(%rbp, %rcx)	#to do: use this instead of push
	push	%rax
	inc	%rcx
	shr	$4, %rsi
	test	%rsi, %rsi
	jnz	print_int_push_loop

	add	$2, %rcx

	mov	$0, %rdx

	movb	$0x30, -128(%rbp, %rdx)
	inc	%rdx

	movb	$0x78, -128(%rbp, %rdx)
	inc	%rdx

print_int_pop_loop:		# copy chars from stack
	pop	%rax

	mov	%rax, %rdi
	#call	print_char

	movb	%al, -128(%rbp, %rdx)
	inc	%rdx
	cmp	%rdx, %rcx
	jne	print_int_pop_loop

	movb	$0xa, -128(%rbp, %rdx)
	inc	%rdx

	lea	-128(%rbp), %rsi
	call	write_string
	mov	%rbp, %rsp 	# restore stack pointer
	pop	%rdi
	pop	%rcx
	pop	%rdx
	pop	%rsi
	pop	%rbp
	pop	%rax
	ret

main:
	mov	$0x9084, %rsi
	shl	$16, %rsi
	add	$0xa412, %rsi
	call	print_int
	jmp	exit

exit:
	movq	$EXIT, %rax
	movq	$0, %rdi
	syscall
