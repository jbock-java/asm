#include <stdio.h>
#include <stdbool.h>
#include <sys/stat.h>
#include <stddef.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/types.h>

int main(int argc, char *argv[])
{
	char message[3];
	message[0] = 0x41;
	message[1] = 0x55;
	message[2] = 0x41;
	printf("%.*s", 3, message);
	fflush(stdout);
-	syscall(__NR_exit, 0);
	//return 0;
}
