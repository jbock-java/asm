#include <stdio.h>
#include <sys/stat.h>
#include <stddef.h>
#include <stdlib.h>

int fh = 0;

int main(int argc, char *argv[])
{
	fh = 3;
	printf("%d\n", fh);
	return 0;
}
