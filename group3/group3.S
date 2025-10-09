.equ READ, 0
.equ STDOUT, 1
.equ CLOSE, 3
.equ WRITE, 1
.equ OPEN, 2
.equ FSTAT, 5
.equ EXIT, 1
.equ MMAP, 9
.equ MUNMAP, 11
.equ OFFSET_SIZE, 48
	.text
	.globl	fh
	.bss

fh:
	.zero	4
	.section	.rodata
buffer:
	.quad	0
file:
	.asciz	"data.txt"
st:
	.skip	1024

.text
.globl _start

_mmap:
	movq	$MMAP, %rax
	movq	$0, %rdi	#addr
	movq	$3, %rdx	#prot r=1 w=2
	leaq	st, %rbx
	movq	48(%rbx), %rsi 	#len
	movq	$-1, %r8	#fd
	movq	$0, %r9		#offset
	movq	$34, %r10	#flags map_private=0x02, map_anonymous=0x20
	syscall
	movq	$buffer, %rbx
	movq	%rax, (%rbx)	#store buffer
	ret

_exit:
	movq	$EXIT, %rax
	movq	$0, %rdi
	syscall
	ret

print:
	movq	$WRITE, %rax
	pushq	%rdi		#print contents of rdi
	movq	$STDOUT, %rdi
	pushq	%rsp		#push leaves RSP pointing to the data that was pushed
	popq	%rsi		#copy RSP to RSI
	movq	$1, %rdx	#size
	syscall
	popq	%rdi
	ret

print_ouch:
	movq	$0x4f, %rdi
	call	print
	movq	$0x55, %rdi
	call	print
	movq	$0x43, %rdi
	call	print
	movq	$0x48, %rdi
	call	print
	movq	$0x21, %rdi
	call	print
	movq	$0xa, %rdi
	call	print
	ret

_open:
	movq	$OPEN, %rax
	movq	$file, %rdi 	#filename
	movq	$0, %rsi	#readonly
	movq	$0644, %rdx 	#mode
	syscall
	movq	%rax, fh(%rip)	#store fh
	ret

_stat:
	movq	$FSTAT, %rax
	movq	(fh), %rdi	#load fh
	movq	$st, %rsi	#into st
	syscall
	ret

_read:
	movq	$READ, %rax
	movq	(fh), %rdi 	#load fh
	movq	$buffer, %rsi	#into buffer
	movq	$st, %rbx	#store size
	movq	48(%rbx), %rdx 	#size
	syscall
	ret

_write:
	movq	$WRITE, %rax
	movq	$STDOUT, %rdi
	movq	$buffer, %rsi	#from buffer
	movq	$st, %rbx
	movq	48(%rbx), %rdx 	#size
	syscall
	ret

_close:
	movq	$CLOSE, %rax	#close
	movq	(fh), %rdi 	#fh
	syscall
	ret

_munmap:
	movq	$MUNMAP, %rax	#munmap
	movq	$buffer, %rdi 	#buffer
	movq	$st, %rbx
	movq	48(%rbx), %rsi 	#size
	syscall
	ret

_start:
	pushq	%rbp
	movq	%rsp, %rbp

	movq	$3, fh(%rip)

	call	_open
	call	_stat
	call	_mmap
	call	_read
	call	_write
	call	_close
	call	_munmap
	call	_exit
