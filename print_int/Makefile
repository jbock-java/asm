build:
	$(CC) main.s -c -o print_int.o
	$(LD) -e main -o print_int print_int.o

check: build
	./print_int | md5sum | grep -q ^3cca2fa && printf "\033[1;32m[OK]\033[0m\n"

build_write:
	$(CC) write.s -c -o write.o
	$(LD) -e main -o write write.o

check_write: build_write
	./write | grep -q '^ABC$$' && printf "\033[1;32m[OK]\033[0m\n"


clean:
	rm -f *.o write print_int
