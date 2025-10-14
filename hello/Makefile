default:
	$(CC) hello.s -c -g
	$(LD) -o hello hello.o

check:
	./hello | md5sum | grep -q ^823c843e5 && printf "\033[1;32m[OK]\033[0m\n"

run:
	./hello
