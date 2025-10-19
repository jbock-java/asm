	.equ READ, 0
	.equ CLOSE, 3
	.equ OPEN, 2
	.equ FSTAT, 5
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
linebuf:
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
	push_all
	mov	$MMAP, %rax
	mov	$0, %rdi		#addr
	mov	$3, %rdx		#prot r=1 w=2
	mov	file_size(%rip), %rsi 	#len
	mov	$-1, %r8		#fd
	mov	$0, %r9			#offset
	mov	$34, %r10		#flags map_private=0x02, map_anonymous=0x20
	syscall
	pop_all
	return

exit:
	enter
	push_all
	mov	$EXIT, %rax
	mov	$0, %rdi
	syscall
	pop_all
	return

open_file:
	enter
	push_all
	mov	$OPEN, %rax
	mov	$file, %rdi
	mov	$0, %rsi
	mov	$0644, %rdx
	syscall
	mov	%rax, fh(%rip)
	pop_all
	return

stat_file:
	enter
	push_all
	mov	$FSTAT, %rax
	mov	fh(%rip), %rdi
	lea	st, %rsi
	syscall
	mov	OFFSET_SIZE(%rsi), %rbx
	mov	%rbx, file_size(%rip)
	pop_all
	return

init_file:
	enter
	push_all
	mov	$READ, %rax
	mov	fh(%rip), %rdi
	mov	in(%rip), %rsi
	mov	file_size(%rip), %rdx
	syscall
	pop_all
	return

copy:
	enter
	push_all
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
	pop_all
	return

read_line:
	enter
	sub	$128, %rsp
	push_all
	mov	16(%rbp), %rax
	mov	$0, %rcx
	cmp	%rcx, file_size(%rip)
	je	read_line_done
	mov	in(%rip), %rbx
	add	%rax, %rbx
read_line_loop:
	mov	%rcx, %rdi
	add	linebuf(%rip), %rdi
	mov	(%rbx, %rcx), %rsi
	movb	%sil, (%rdi)
	cmp	$0xa, %sil
	je	read_line_done
	inc	%rcx
	cmp	%rcx, file_size(%rip)
	jne	read_line_loop
read_line_done:
	mov	%rcx, %rax
	pop_all
	return

close:
	enter
	push_all
	mov	$CLOSE, %rax
	lea	fh, %rdi
	syscall
	pop_all
	return

munmap:
	enter
	push_all
	mov	$MUNMAP, %rax
	lea	in, %rdi
	mov	file_size(%rip), %rsi
	syscall
	mov	$MUNMAP, %rax
	lea	out, %rdi
	mov	file_size(%rip), %rsi
	syscall
	pop_all
	return

print_lines:
	enter
	sub	$128, %rsp
	push_all
	mov	$0, %rbx

print_lines_loop:

	push	%rbx
	log	%rbx
	call	read_line

	add	%rax, %rbx


	push	linebuf(%rip)
	plop
	plop


	inc	%rbx

	cmp	$30, %rbx

	jl	print_lines_loop
print_lines_done:
	push	$0x31
	call	write_char_debug
	pop_all
	return

main:
	enter
	push_all
	call	open_file
	call	stat_file
	call	get_memory
	mov	%rax, in(%rip)
	call	get_memory
	mov	%rax, out(%rip)
	call	get_memory
	mov	%rax, linebuf(%rip)
	call	init_file
	call	print_lines
	#push	$0xc
	#call	read_line
	#push	linebuf(%rip)
	#push	%rax
	#call	write_string

	call	close
	call	munmap
	call	exit
