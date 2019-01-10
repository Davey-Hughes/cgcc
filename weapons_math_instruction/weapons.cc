/* https://codegolf.stackexchange.com/questions/82773/weapons-of-math-instruction */

#include <iostream>
#include <vector>
#include <iomanip>

#include <cstdint>
#include <cmath>
#include <cstring>

extern "C" double weapons_asm(int64_t *, long unsigned);

double
weapons_c(std::vector<int64_t> input)
{

	double ret = (double) input[0];

	for (long unsigned i = 1; i < input.size(); ++i) {
		switch (i % 5) {
		case 1:
			ret += (double) input[i];
			break;
		case 2:
			ret -= (double) input[i];
			break;
		case 3:
			ret *= (double) input[i];
			break;
		case 4:
			ret /= (double) input[i];
			break;
		case 0:
			ret = std::pow(ret, (double) input[i]);
			break;
		}
	}

	return ret;
}


int
main(int argc, char **argv)
{
	int64_t x;
	double out;
	bool use_asm = false;
	std::vector<int64_t> input(0);

	while (std::cin >> x) {
		input.push_back(x);
	}

	if (input.size() == 0) {
		std::cout << "Please specify at least one input value" << std::endl;
		return 1;
	}

	for (int i = 0; i < argc; ++i) {
		if (strncmp(argv[i], "--use_asm", 9) == 0) {
			use_asm = true;
			break;
		}
	}

	if (use_asm) {
		out = weapons_asm(input.data(), input.size());
	} else {
		out = weapons_c(input);
	}

	std::cout << std::fixed << out << std::endl;

	return 0;
}
