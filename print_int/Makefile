print_int:
	$(CC) main.s -c -o print_int.o
	$(LD) -e main -o print_int print_int.o

check: print_int
	./print_int | md5sum | grep -q ^3cca2fa && printf "\033[1;32m[OK]\033[0m\n"

write:
	$(CC) write.s -c -o write.o
	$(LD) -e main -o write write.o

check_write: write
	./write | grep -q '^ABC$$' && printf "\033[1;32m[OK]\033[0m\n"

strcmp:
	$(CC) strcmp.s -c -o strcmp.o
	$(LD) -e main -o strcmp strcmp.o

check_strcmp: strcmp
	./strcmp | md5sum | grep -q ^00350de && printf "\033[1;32m[OK]\033[0m\n"

clean:
	rm -f *.o write print_int strcmp
