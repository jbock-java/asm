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

.data

fh:
	.quad	0
buffer:
	.quad	0
st:
	.zero	1024

.section .rodata

file:
	.asciz	"data.txt"

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
	movq	%rax, buffer(%rip)	#store buffer
	ret

_exit:
	movq	$EXIT, %rax
	movq	$0, %rdi
	syscall
	ret

_print:
	movq	$WRITE, %rax
	pushq	%rdi		#print contents of rdi
	movq	$STDOUT, %rdi
	pushq	%rsp		#push leaves RSP pointing to the data that was pushed
	popq	%rsi		#copy RSP to RSI
	movq	$1, %rdx	#size
	syscall
	popq	%rdi
	ret

_print_ouch:
	movq	$0x4f, %rdi
	call	_print
	movq	$0x55, %rdi
	call	_print
	movq	$0x43, %rdi
	call	_print
	movq	$0x48, %rdi
	call	_print
	movq	$0x21, %rdi
	call	_print
	movq	$0xa, %rdi
	call	_print
	ret

_open:
	movq	$OPEN, %rax
	movq	$file, %rdi 		#filename
	movq	$0, %rsi		#readonly
	movq	$0644, %rdx 		#mode
	syscall
	movq	%rax, fh(%rip)		#store fh
	ret

_stat:
	movq	$FSTAT, %rax
	movq	fh(%rip), %rdi		#load fh
	leaq	st, %rsi		#into st
	syscall
	ret

_read:
	movq	$READ, %rax
	movq	fh(%rip), %rdi 		#int fd
	movq	buffer(%rip), %rsi	#char *buf
	leaq	st, %rbx
	movq	48(%rbx), %rdx 		#len
	syscall
	ret

_write:
	movq	$WRITE, %rax
	movq	$STDOUT, %rdi		#int fd
	movq	buffer(%rip), %rsi	#char *buf
	leaq	st, %rbx
	movq	48(%rbx), %rdx 		#len
	syscall
	ret

_close:
	movq	$CLOSE, %rax		#close
	leaq	fh, %rdi 		#fh
	syscall
	ret

_munmap:
	movq	$MUNMAP, %rax		#munmap
	leaq	buffer, %rdi 		#buffer
	leaq	st, %rbx
	movq	48(%rbx), %rsi 		#len
	syscall
	ret

_start:
	pushq	%rbp
	movq	%rsp, %rbp

	call	_open
	call	_stat
	call	_mmap
	call	_read
	call	_write
	call	_close
	call	_munmap
	call	_exit

	leave
