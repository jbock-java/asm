build:
	$(CC) hello.s -c
	$(LD) -o hello hello.o

check: build
	./hello | md5sum | grep -q ^823c843e5 && printf "\033[1;32m[OK]\033[0m\n"

clean:
	rm -f hello
