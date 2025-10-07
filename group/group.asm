section .data
	file DD "data.txt"
section .bss
	buffer: resb 1024
	st: resb 1024
section .text

global main

main:
;	mov	rax, 1		;write
;	mov	rdi, 1		;stdout
;	push	10		;\n
;	push	rsp		;push leave RSP pointing to the data that was pushed
;	pop	rsi		;copy RSP to RSI
;	mov	rdx, 1		;size
;	syscall

	mov	rax, 2		;open
	mov	rdi, file	;filename
	mov	rsi, 0		;readonly
	mov	rdx, 0644	;mode
	syscall
	mov	rdi, rax	;copy fh
	
	mov	rax, 0		;read
	mov	rsi, buffer	;into buffer
	mov	rdx, 1024	;size
	syscall

	mov	rax, 1		;write
	mov	rdi, 1		;stdout
	mov	rsi, buffer	;from buffer
	mov	rdx, st + 48	;offset of st_size
	syscall

	mov	rax, 60		;exit
	mov	rdi, 0		;status
	syscall
