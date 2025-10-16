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

	.data

fh:
	.quad	0
buffer:
	.quad	0
siz:
	.quad	0
st:
	.zero	1024

	.section .rodata

file:
	.asciz	"data.txt"

	.text
	.globl main

mmap:
	movq	$MMAP, %rax
	movq	$0, %rdi		#addr
	movq	$3, %rdx		#prot r=1 w=2
	movq	siz(%rip), %rsi 	#len
	movq	$-1, %r8		#fd
	movq	$0, %r9			#offset
	movq	$34, %r10		#flags map_private=0x02, map_anonymous=0x20
	syscall
	movq	%rax, buffer(%rip)	#store buffer
	ret

exit:
	movq	$EXIT, %rax
	movq	$0, %rdi
	syscall
	ret

print:
	movq	$WRITE, %rax
	pushq	%rdi			#print contents of rdi
	movq	$STDOUT, %rdi
	pushq	%rsp			#push leaves RSP pointing to the data that was pushed
	popq	%rsi			#copy RSP to RSI
	movq	$1, %rdx		#size
	syscall
	popq	%rdi
	ret

print_ouch:
	movq	$CHAR_O, %rdi
	call	print
	movq	$CHAR_U, %rdi
	call	print
	movq	$CHAR_C, %rdi
	call	print
	movq	$CHAR_H, %rdi
	call	print
	movq	$BANG, %rdi
	call	print
	movq	$NEWLINE, %rdi
	call	print
	ret

open:
	movq	$OPEN, %rax
	movq	$file, %rdi 		#filename
	movq	$0, %rsi		#readonly
	movq	$0644, %rdx 		#mode
	syscall
	movq	%rax, fh(%rip)		#store fh
	ret

stat:
	movq	$FSTAT, %rax
	movq	fh(%rip), %rdi		#load fh
	leaq	st, %rsi		#into st
	syscall
	movq	48(%rsi), %rbx		#store size
	movq	%rbx, siz(%rip)
	ret

read:
	movq	$READ, %rax
	movq	fh(%rip), %rdi 		#int fd
	movq	buffer(%rip), %rsi	#char *buf
	movq	siz(%rip), %rdx 	#len
	syscall
	ret

write:
	movq	$WRITE, %rax
	movq	$STDOUT, %rdi		#int fd
	movq	buffer(%rip), %rsi	#char *buf
	movq	siz(%rip), %rdx 	#len
	syscall
	ret

close:
	movq	$CLOSE, %rax		#close
	leaq	fh, %rdi 		#fh
	syscall
	ret

munmap:
	movq	$MUNMAP, %rax		#munmap
	leaq	buffer, %rdi 		#buffer
	movq	siz(%rip), %rsi 	#len
	syscall
	ret

main:
	pushq	%rbp
	movq	%rsp, %rbp

	call	open
	call	stat
	call	mmap
	call	read
	call	write
	call	close
	call	munmap
	call	exit
