#https://www.youtube.com/watch?v=3nYHV5zIQGA
.globl _start

.hello.str:
	.asciz "12345678\n"

.text

# void print_chars(int {rsi}, int {rdx});
print_chars:
	movq	$1, %rax
	movq	$1, %rdi
	syscall
	ret

_start:
	#https://stackoverflow.com/questions/29790175/assembly-x86-leave-instruction
	pushq	%rbp
	movq	%rsp, %rbp

	leaq	.hello.str, %rsi
	movq	$10, %rdx
	call	print_chars

	movq	$60, %rax
	movq	$0, %rdi
	syscall
