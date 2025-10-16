#include <stdio.h>
#include <stdbool.h>
#include <sys/stat.h>
#include <stddef.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>

char* in;
char* out;

int get_zero() {
	int result = 128;
	while(true) {
		result = result / 2;
		if (result == 16) {
			return 0;
		}
	}
	return 1;
}

int get_one() {
	int result = 128;
	while(true) {
		result = result / 2;
		if (result == 8) {
			return 1;
		}
	}
	return 2;
}

int get_two() {
	int result = 128;
	while(true) {
		result = result / 2;
		if (result == 4) {
			return 2;
		}
	}
	return 1;
}

int get_three() {
	int result = 128;
	while(true) {
		result = result / 2;
		if (result == 32) {
			return 3;
		}
	}
	return 2;
}

int main(int argc, char *argv[])
{
	in = malloc(4);
	out = malloc(4);
	in[0] = '0';
	in[1] = 'x';
	in[2] = 'a';
	in[3] = '\n';
	int zero = get_zero();
	int one = get_one();
	int two = get_two();
	int three = get_three();
	out[zero] = in[zero];
	out[one] = in[one];
	out[two] = in[two];
	out[three] = in[three];
	syscall(__NR_write, 1, out, 4);
	return 0;
}
