default:
	$(CC) cat.s -c -g
	$(LD) -o cat cat.o

test:
	@./cat | md5sum | grep -q ^06aa985f3 && printf "\033[1;32m[OK]\033[0m\n"

clean:
	@rm -f cat.o cat
