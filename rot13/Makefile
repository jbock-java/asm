default:
	nasm -f elf64 rot13.asm -o rot13.o
	ld rot13.o -o rot13 -z noexecstack -no-pie -s

run:
	./rot13 -if test.txt -of rotated.txt
