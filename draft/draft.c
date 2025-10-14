#include <stdio.h>
#include <sys/stat.h>
#include <stddef.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>

int main(int argc, char *argv[])
{
	char out[11];
	out[0] = '0';
	out[1] = 'x';
	out[2] = 'd';
	out[3] = 'e';
	out[4] = 'a';
	out[5] = 'd';
	out[6] = 'b';
	out[7] = 'e';
	out[8] = 'e';
	out[9] = 'f';
	out[10] = '\n';
	syscall(__NR_write, 1, out, 11);
	return 0;
}
