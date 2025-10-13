#include <stdio.h>
#include <sys/stat.h>
#include <stddef.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>

int fh = 0;
int i = 0;

int main(int argc, char *argv[])
{
	char out[5];
	out[i++] = '0';
	out[i++] = 'x';
	out[i++] = '4';
	out[i++] = '1';
	out[i++] = '\n';
	syscall(__NR_write, 1, out, 5);
	return 0;
}
