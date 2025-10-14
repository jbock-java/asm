build:
	$(CC) print_int.s -c
	$(LD) -e main -o print_int print_int.o

run: build
	./print_int

check: build
	./print_int | md5sum | grep -q ^823c843e5 && printf "\033[1;32m[OK]\033[0m\n"

clean:
	rm -f print_int
