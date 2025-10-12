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

my_number:
	.quad 0x41

	.text
	.globl _start

# void print_chars(char *rsi, int rdx);
print_chars:
	movq	$WRITE, %rax
	movq	$STDOUT, %rdi
	syscall
	ret

# void print_int_h(int {rsi});
# 	Prints hexadecimal value in {rsi} to stdout.
_print_int_h:
	push	%rax
	push	%rbp
	push	%rsi
	push	%rdx

	mov	%rsp, %rbp 	# save base stack pointer

	# value is kept in {rsi} and low bits are shifted off, four by four
	# do all arithmetic in {rax}

	# move trailing '\n' onto stack
	push	$0xa

_loop:

	mov	%sil, %al	#
	and	$15, %al	# %al contains low nibble of %rsi
	add	$48, %al	# %al now correctly contains ascii "0"-"9"
	cmp	$57, %al	#
	jle	_insert_byte
	add	$39, %al	# adjust %al for ascii "a"-"f"
_insert_byte:
	dec	%rsp
	mov	%al, (%rsp)	# move this ascii value into next slot on stack
	shr	$4, %rsi	# go on to next lowest bit
	test	 %rsi, %rsi	# loop until nothing nonzero left
	jnz	_loop

	# move leading '0x' onto stack
	push	$0x78		#x
	push	$0x30		#0

	# get ready to print
	mov	%rbp, %rdx	##
	sub	%rsp, %rdx	## %rdx will be length of number in bytes
	mov	%rsp, %rsi	## address of top of stack
	call	print_chars	## print out bytes
	mov	%rbp, %rsp 	## restore stack pointer

	pop	%rdx
	pop	%rsi
	pop	%rbp
	pop	%rax

	ret

_start:
	mov	my_number, %rsi
	call	_print_int_h
	jmp	_exit

_exit:
	movq	$EXIT, %rax
	movq	$0, %rdi
	syscall
