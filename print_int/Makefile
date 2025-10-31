CFLAGS += -x
CFLAGS += assembler-with-cpp

print_int:
	$(CC) $(CFLAGS) main.s -o print_int

check: print_int
	./print_int | md5sum | grep -q ^3cca2fa && printf "\033[1;32m[OK]\033[0m\n"

write:
	$(CC) $(CFLAGS) write.s -o write

check_write: write
	./write | grep -q '^ABC$$' && printf "\033[1;32m[OK]\033[0m\n"

strcmp:
	$(CC) $(CFLAGS) strcmp.s -o strcmp

check_strcmp: strcmp
	./strcmp | md5sum | grep -q ^00350de && printf "\033[1;32m[OK]\033[0m\n"

clean:
	rm -f *.o write print_int strcmp
