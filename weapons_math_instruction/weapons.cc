/* https://codegolf.stackexchange.com/questions/82773/weapons-of-math-instruction */

#include <iostream>
#include <vector>
#include <iomanip>

#include <cmath>
#include <cstring>

extern "C" double weapons_asm(double *, long unsigned);

double
weapons_c(std::vector<double> input)
{

	double ret = input[0];

	for (long unsigned i = 1; i < input.size(); ++i) {
		switch (i % 5) {
		case 1:
			ret += input[i];
			break;
		case 2:
			ret -= input[i];
			break;
		case 3:
			ret *= input[i];
			break;
		case 4:
			ret /= input[i];
			break;
		case 0:
			ret = std::pow(ret, input[i]);
			break;
		}
	}

	return ret;
}


int
main(int argc, char **argv)
{
	double x;
	bool use_asm = false;
	std::vector<double> input(0);

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
		x = weapons_asm(input.data(), input.size());
	} else {
		x = weapons_c(input);
	}

	std::cout << std::fixed << x << std::endl;

	return 0;
}
