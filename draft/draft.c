#include <stdio.h>
#include <sys/stat.h>
#include <stddef.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
	void *signbuf = malloc(4096);
	printf("%p\n", signbuf);
	free(signbuf);
	return 0;
}
