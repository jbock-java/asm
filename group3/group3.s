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

	.data

fh:
	.quad	0
in:
	.quad	0
out:
	.quad	0
line:
	.quad	0
file_size:
	.quad	0
st:
	.zero	1024

	.section .rodata

file:
	.asciz	"data.txt"

	.text
	.globl main

.include "../print_int/print_int.s"

get_memory:
	enter
	mov	$MMAP, %rax
	mov	$0, %rdi		#addr
	mov	$3, %rdx		#prot r=1 w=2
	mov	file_size(%rip), %rsi 	#len
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

open_file:
	enter
	mov	$OPEN, %rax
	mov	$file, %rdi
	mov	$0, %rsi
	mov	$0644, %rdx
	syscall
	mov	%rax, fh(%rip)
	return

stat_file:
	enter
	mov	$FSTAT, %rax
	mov	fh(%rip), %rdi
	lea	st, %rsi
	syscall
	mov	48(%rsi), %rbx
	mov	%rbx, file_size(%rip)
	return

init_file:
	enter
	mov	$READ, %rax
	mov	fh(%rip), %rdi
	mov	in(%rip), %rsi
	mov	file_size(%rip), %rdx
	syscall
	return

copy:
	enter
	mov	$0, %rcx
	cmp	%rcx, file_size(%rip)
	je	copy_done
	mov	in(%rip), %rbx
copy_loop:
	mov	%rcx, %rdi
	add	out(%rip), %rdi
	mov	(%rbx, %rcx), %rsi
	movb	%sil, (%rdi)
	inc	%rcx
	cmp	%rcx, file_size(%rip)
	jne	copy_loop
copy_done:
	return

read_line:
	enter
	sub	$128, %rsp
	mov	$0, %rcx
	cmp	%rcx, file_size(%rip)
	je	read_line_done
	mov	in(%rip), %rbx
read_line_loop:
	mov	%rcx, %rdi
	add	line(%rip), %rdi
	mov	(%rbx, %rcx), %rsi
	movb	%sil, (%rdi)
	cmp	$0xa, %sil
	je	read_line_done
	inc	%rcx
	cmp	%rcx, file_size(%rip)
	jne	read_line_loop
read_line_done:
	mov	%rcx, %rax
	return

copy_lines:
	enter
	sub	$128, %rsp
	mov	$0, %rcx
	cmp	%rcx, file_size(%rip)
	je	copy_lines_done
	mov	in(%rip), %rbx
copy_lines_loop:
	mov	%rcx, %rdi
	add	out(%rip), %rdi
	mov	(%rbx, %rcx), %rsi
	movb	%sil, (%rdi)
	inc	%rcx
	cmp	%rcx, file_size(%rip)
	jne	copy_lines_loop
copy_lines_done:
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
	mov	file_size(%rip), %rsi
	syscall
	mov	$MUNMAP, %rax
	lea	out, %rdi
	mov	file_size(%rip), %rsi
	syscall
	return

main:
	enter
	call	open_file
	call	stat_file
	call	get_memory
	mov	%rax, in(%rip)
	call	get_memory
	mov	%rax, out(%rip)
	call	get_memory
	mov	%rax, line(%rip)
	call	init_file
	call	read_line
	#call	copy

	push	line(%rip)
	push	%rax
	call	write_string
	call	write_newline
	pop	%rax
	pop	%rax

	call	close
	call	munmap
	call	exit
