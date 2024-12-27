default:
	nasm -f elf64 hello.asm -o hello.o
	ld hello.o -o hello -z noexecstack -no-pie -s

run:
	./hello
