#https://www.youtube.com/watch?v=_hbZN4khAyU
#https://github.com/xmdi/SCHIZONE
	.equ	READ, 0
	.equ	STDOUT, 1
	.equ	CLOSE, 3
	.equ	WRITE, 1
	.equ	OPEN, 2
	.equ	FSTAT, 5
	.equ	EXIT, 60
	.equ	MMAP, 9
	.equ	MUNMAP, 11
	.equ	OFFSET_SIZE, 48
	.equ	CHAR_O, 0x4f
	.equ	CHAR_U, 0x55
	.equ	CHAR_C, 0x43
	.equ	CHAR_H, 0x48
	.equ	BANG, 0x21
	.equ	NEWLINE, 0xa

	.data

	.text
	.globl _start

# char *rsi, int rdx;
print_chars:
	movq	$WRITE, %rax
	movq	$STDOUT, %rdi
	syscall
	ret

# Prints hexadecimal value in rsi to stdout.
print_int:
	push	%rax
	push	%rbp
	push	%rsi
	push	%rdx
	push	%rcx
	mov	%rsp, %rbp 	# save stack pointer
	mov	$0, %rcx
	movb	$0xa, -64(%rbp, %rcx)
	inc	%rcx
print_int_loop:
	mov	%rsi, %rax
	and	$15, %rax
	add	$48, %rax	# %rax now contains ascii "0"-"9"
	cmp	$57, %rax
	jle	print_int_after_adjust
	add	$39, %rax	# adjust for ascii "a"-"f"
print_int_after_adjust:
	movb	%al, -64(%rbp, %rcx)
	inc	%rcx
	shr	$4, %rsi
	test	%rsi, %rsi
	jnz	print_int_loop
	movb	$0x78, -64(%rbp, %rcx)
	inc	%rcx
	movb	$0x30, -64(%rbp, %rcx)
	inc	%rcx
	leaq	-64(%rbp), %rsi
	mov	%rcx, %rdx	# len
le_print:
	call	print_chars
	mov	%rbp, %rsp 	# restore stack pointer
	pop	%rcx
	pop	%rdx
	pop	%rsi
	pop	%rbp
	pop	%rax
	ret

_start:
	mov	$0xdeadbeef, %rsi
	call	print_int
	jmp	_exit

_exit:
	movq	$EXIT, %rax
	movq	$0, %rdi
	syscall
