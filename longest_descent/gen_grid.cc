#include <iostream>
#include <string>
#include <random>
#include <bits/stdc++.h>

int
main(int argc, char **argv)
{
	int n, m;

	if (argc < 3) {
		std::cout << "Usage: ./gen_grid n m" << std::endl;
	}

	n = std::stoi(argv[1]);
	m = std::stoi(argv[2]);

	std::random_device rd; // seed engine
	std::mt19937 rng(rd()); // random number engine (mersenne-twister)
	std::uniform_int_distribution<int> uni(0, INT_MAX); // unbiased

	std::cout << n << " " << m << "\n\n";
	for (int i = 0; i < n * m; ++i) {
		std::cout << uni(rng);

		if (i % n == m - 1) {
			std::cout << "\n";
		} else {
			std::cout << " ";
		}
	}

	return 0;
}
