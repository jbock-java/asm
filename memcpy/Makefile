CFLAGS += -D_GNU_SOURCE
CFLAGS += -Wall
CFLAGS += -pedantic-errors
CFLAGS += -Og

build:
	$(CC) $(CFLAGS) memcpy.s -o memcpy

clean:
	@rm -f memcpy.o memcpy

check: build
	./memcpy | grep -q ^0xa$ && printf "\033[1;32m[OK]\033[0m\n"
