build:
	$(CC) main.s -c -o print_int.o
	$(LD) -e main -o print_int print_int.o

run: build
	./print_int

check: build
	./print_int | md5sum | grep -q ^0d0f199 && printf "\033[1;32m[OK]\033[0m\n"

clean:
	rm -f print_int
