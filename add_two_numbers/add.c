/*
 * https://codegolf.stackexchange.com/questions/84260/add-two-numbers/86453#86453
 */

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

int add(int a, int b) {
	asm (
		".p2align 4\n"
		"add%=:\n\t"
		"	add	eax, ecx\n"
		"add_end%=:\n"
		: "+a" (a), "+c" (b)
	);
	return a;
}

int main(int argc, char** argv) {
	assert(argc > 2);
	int a = atoi(argv[1]), b = atoi(argv[2]);

	printf("%d\n", add(a, b));

	return 0;
}
