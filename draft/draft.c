#include <stdio.h>
#include <sys/stat.h>
#include <stddef.h>

int main(int argc, char *argv[])
{
	printf("%ld\n", offsetof(struct stat, st_size));
	return 0;
}
