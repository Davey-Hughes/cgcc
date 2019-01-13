/* https://codegolf.stackexchange.com/questions/35038/generate-the-group-table-for-z-n */
#include <iostream>
#include <sstream>
#include <iomanip>

#include <cstring>
#include <cstdio>

extern "C" char *zn_asm(int, char *);

template<typename T> void printNum(T t, const int &width, std::stringstream &s)
{
	s << std::right << std::setw(width) << std::setfill(' ') << t;
}

std::string
zn_c(int n)
{
	const int width = std::to_string(n - 1).length() + 1;
	std::stringstream s;

	for (int i = 0; i < n; ++i) {
		for (int k = 0; k < n; ++k) {
			printNum((i + k) % n, k ? width : width - 1, s);
		}

		if (i < n - 1) {
			s << "\n";
		}
	}

	return s.str();
}

int
main(int argc, char **argv)
{
	int n;
	bool use_asm = false;

	std::cin >> n;

	for (int i = 1; i < argc; ++i) {
		if (strncmp(argv[i], "--use_asm", 9) == 0) {
			use_asm = true;
			break;
		}
	}

	if (use_asm) {
		size_t total_len = std::to_string(n).length() * (n * n + n);
		char *output = new char[total_len];

		for (size_t i = 0; i < total_len; ++i) {
			output[i] = '\0';
		}

		char *print = zn_asm(n, output + total_len - 1);
		std::cout << print << std::endl;

		delete[] output;
	} else {
		std::cout << zn_c(n) << std::endl;
	}

	return 0;
}
