.equ READ, 0
.equ STDOUT, 1
.equ CLOSE, 3
.equ WRITE, 1
.equ OPEN, 2
.equ FSTAT, 5
.equ EXIT, 60
.equ MMAP, 9
.equ MUNMAP, 11
.equ OFFSET_SIZE, 48
.equ CHAR_O, 0x4f
.equ CHAR_U, 0x55
.equ CHAR_C, 0x43
.equ CHAR_H, 0x48
.equ BANG, 0x21
.equ NEWLINE, 0xa


	.text
	.globl _start

_print:
	movq	$WRITE, %rax
	pushq	%rdi			#print contents of rdi
	movq	$STDOUT, %rdi
	pushq	%rsp			#push leaves RSP pointing to the data that was pushed
	popq	%rsi			#copy RSP to RSI
	movq	$1, %rdx		#size
	syscall
	popq	%rdi
	ret

_start:
	pushq	%rbp
	movq	%rsp, %rbp
	movq	$CHAR_O, %rdi
	call	_print


	leave
