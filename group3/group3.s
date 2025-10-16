	.equ READ, 0
	.equ STDOUT, 1
	.equ CLOSE, 3
	.equ WRITE, 1
	.equ OPEN, 2
	.equ FSTAT, 5
	.equ EXIT, 60
	.equ MMAP, 9
	.equ MUNMAP, 11
	.equ OFFSET_SIZE, 48		# struct stat

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

	.data

fh:
	.quad	0
in:
	.quad	0
out:
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
	enter
	mov	$MMAP, %rax
	mov	$0, %rdi		#addr
	mov	$3, %rdx		#prot r=1 w=2
	mov	siz(%rip), %rsi 	#len
	mov	$-1, %r8		#fd
	mov	$0, %r9			#offset
	mov	$34, %r10		#flags map_private=0x02, map_anonymous=0x20
	syscall
	return

exit:
	enter
	mov	$EXIT, %rax
	mov	$0, %rdi
	syscall
	return

open:
	enter
	mov	$OPEN, %rax
	mov	$file, %rdi
	mov	$0, %rsi
	mov	$0644, %rdx
	syscall
	mov	%rax, fh(%rip)
	return

stat:
	enter
	mov	$FSTAT, %rax
	mov	fh(%rip), %rdi
	lea	st, %rsi
	syscall
	mov	48(%rsi), %rbx
	mov	%rbx, siz(%rip)
	return

read:
	enter
	mov	$READ, %rax
	mov	fh(%rip), %rdi
	mov	in(%rip), %rsi
	mov	siz(%rip), %rdx
	syscall
	return

copy:
	enter
	mov	$0, %rcx
	cmp	%rcx, siz(%rip)
	je	copy_done
	mov	in(%rip), %rsi
copy_loop:
	mov	%rcx, %rdx
	add	out(%rip), %rdx
	mov	(%rsi, %rcx), %rdi
	movb	%dil, (%rdx)
	inc	%rcx
	cmp	%rcx, siz(%rip)
	jne	copy_loop
copy_done:
	return

write:
	enter
	mov	$WRITE, %rax
	mov	$STDOUT, %rdi
	mov	out(%rip), %rsi
	mov	siz(%rip), %rdx
	syscall
	return

close:
	enter
	mov	$CLOSE, %rax
	lea	fh, %rdi
	syscall
	return

munmap:
	enter
	mov	$MUNMAP, %rax
	lea	in, %rdi
	mov	siz(%rip), %rsi
	syscall
	mov	$MUNMAP, %rax
	lea	out, %rdi
	mov	siz(%rip), %rsi
	syscall
	return

main:
	call	open
	call	stat
	call	mmap
	mov	%rax, in(%rip)
	call	read
	call	mmap
	mov	%rax, out(%rip)
	call	copy
	call	write
	call	close
	call	munmap
	call	exit
