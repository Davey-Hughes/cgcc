/*
 * https://codegolf.stackexchange.com/questions/178326/length-of-the-longest-descent
 */

#include <iostream>
#include <vector>

#include <string.h>

extern "C" int descent_asm(int, int, int *);

static int *lens;

int
descent_helper(int i, int n, int m, int *arr)
{
	int longest = 0;

	if (lens[i] > -1) {
		return lens[i];
	}

	// recursively check for each valid direction
	// up
	if (i - n >= 0 && arr[i] > arr[i - n]) {
		longest = std::max(longest, descent_helper(i - n, n, m, arr) + 1);
	}

	// down
	if (i + n < (n * m) && arr[i] > arr[i + n]) {
		longest = std::max(longest, descent_helper(i + n, n, m, arr) + 1);
	}

	// left
	if (i % n != 0 && arr[i] > arr[i - 1]) {
		longest = std::max(longest, descent_helper(i - 1, n, m, arr) + 1);
	}

	// right
	if (i % n != n - 1 && arr[i] > arr[i + 1]) {
		longest = std::max(longest, descent_helper(i + 1, n, m, arr) + 1);
	}

	lens[i] = longest;
	return longest;
}

int
descent_c(int n, int m, int *arr)
{
	int longest = 0;

	for (int i = 0; i < n * m; ++i) {
		longest = std::max(longest, descent_helper(i, n, m, arr));
	}

	return longest;
}

int
main(int argc, char **argv)
{
	int n, m, steps;
	int *arr;
	bool use_asm = false;

	for (int i = 1; i < argc; ++i) {
		if (strncmp(argv[i], "--use_asm", 9) == 0) {
			use_asm = true;
		}
	}

	// get dimensions of array from stdin
	std::cin >> n >> m;

	arr = new int[n * m];

	// populate array from stdin
	for (int i = 0; i < n * m; ++i) {
		std::cin >> arr[i];
	}

	// calculate longest descent using asm or c
	if (use_asm) {
		steps = descent_asm(n, m, arr);
	} else {
		lens = new int[n * m];

		// initialize dynamic programming array
		for (int i = 0; i < n * m; ++i) {
			lens[i] = -1;
		}

		steps = descent_c(n, m, arr);

		delete[] lens;
	}

	std::cout << steps << std::endl;

	delete[] arr;
}
