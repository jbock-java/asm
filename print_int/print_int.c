#include <stdint.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>

const char *format = "0x%.*s\n";

void print_int(uint64_t n)
{
	char tmp[16], output[16];
	uint8_t count = 0;
	do {
		char c = 0xf & n;
		c += 0x30;		// c now contains ascii "0"-"9"
		if (c > 0x39) {
			c += 0x27;	// adjust for ascii "a"-"f"
		}
		tmp[count++] = c;
		n = n >> 4;
	} while(n != 0);
	for (uint8_t i = 0; i < count; i++) {
		output[i] = tmp[count - i - 1];
	}
	printf(format, count, output);
}

int main(int argc, char *argv[])
{
	print_int(0x9084a412);
	print_int(0);
	return 0;
}
