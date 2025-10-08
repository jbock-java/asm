default:
	nasm -f elf64 group.asm -o group.o
	gcc -no-pie group.o -o group -g

test:
	@./group | md5sum | grep -q ^06aa985f3 && printf "\033[1;32m[OK]\033[0m\n"

clean:
	@rm -f group.o group
