section .data
	file DD "data.txt"
section .bss
	buffer: resb 1024
section .text

global main
main:
	mov rax, 2	;open
	mov rdi, file	;filename
	mov rsi, 0	;read only
	syscall
	
	mov rdi, rax	;file handle
	mov rax, 0	;read
	mov rsi, buffer	;into buffer
	mov rdx, 1024	;size
	syscall

	mov rax, 1	;write
	mov rdi, 1	;stdout
	mov rcx, buffer ;from buffer
	mov rdx, 30	;size
	syscall

	mov rax, 60	;exit
	mov rdi, 0	;status
	syscall
