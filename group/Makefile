default:
	nasm -f elf64 group.asm -o group.o
	gcc -no-pie group.o -o group -g

printstr:
	nasm -f elf64 printstr.asm -o printstr.o
	gcc -no-pie printstr.o -o printstr -g

clean:
	@rm -f *.o group printstr
