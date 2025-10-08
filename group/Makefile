default:
	nasm -f elf64 cat.nasm -o cat.o
	gcc -no-pie cat.o -o cat -g

test:
	@./cat | md5sum | grep -q ^06aa985f3 && printf "\033[1;32m[OK]\033[0m\n"

clean:
	@rm -f cat.o cat
