section .data
	st_size:		dd 0 
	fh:			dd 0 
	buffer:			dd 0 
	file:			dd "data.txt"
section .bss
	st:			resb 1024
section .text

global main

do_brk:
        mov	rax, 12		;brk
        mov	rdi, 0
	syscall
	ret

do_mmap:
        mov	rax, 9		;mmap
        mov	rdi, 0		;addr
        mov	rdx, 3		;prot r=1 w=2
        mov	rsi, [st + 48] 	;len
        mov	r8, -1		;fd
        mov	r9, 0		;offset
        mov	r10, 34		;flags map_private=0x02, map_anonymous=0x20
	syscall
        ret

exit:
	mov	rax, 60
	mov	rdi, 0
	syscall
	ret

print:
	mov	rax, 1		;write
	push	rdi		;print contents of rdi
	mov	rdi, 1		;stdout
	push	rsp		;push leaves RSP pointing to the data that was pushed
	pop	rsi		;copy RSP to RSI
	mov	rdx, 1		;size
	syscall
	pop	rdi
	ret

print_ouch:
	mov	rdi, 0x4f
	call	print
	mov	rdi, 0x55
	call	print
	mov	rdi, 0x43
	call	print
	mov	rdi, 0x48
	call	print
	mov	rdi, 0x21
	call	print
	mov	rdi, 0xa
	call	print
	ret

main:

	mov	rax, 2		;open
	mov	rdi, file	;filename
	mov	rsi, 0		;readonly
	mov	rdx, 0644	;mode
	syscall
	mov	[fh], rax	;store fh

	mov	rax, 5		;fstat
	mov	rdi, [fh]	;copy fh
	mov	rsi, st		;into st
	syscall

	call	do_brk
	call	do_brk
	call	do_brk
	call	do_mmap
	mov	[buffer], rax	;store buffer

	mov	rax, 0		;read
	mov	rdi, [fh]	;from fh
	mov	rsi, buffer	;into buffer
	mov	rdx, st + 48 	;size
	syscall

	mov	rax, 1		;write
	mov	rdi, 1		;stdout
	mov	rsi, buffer	;from buffer
	mov	rdx, st + 48	;offset of st_size
	syscall

	mov	rax, 3		;close
	mov	rdi, [fh]	;fh
	syscall

	mov	rax, 11		;munmap
	mov	rdi, buffer	;buffer
        mov	rsi, [st + 48] 	;len
	syscall

	call	exit
