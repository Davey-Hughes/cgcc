/* https://codegolf.stackexchange.com/questions/178344/oreoorererereoo */

#include <iostream>
#include <regex>

#include <string.h>

extern "C" void oreo_asm(char *, char *);

void
oreo_c(std::string input)
{
	int i = 0;
	while (i < (int) input.length()) {
		if (input[i] == 'o') {
			std::cout << std::string(input.length(), 'o') << std::endl;
			i++;
		} else {
			std::cout << ' ';
			std::cout << std::string(input.length() - 2, 'e');
			std::cout << ' ' << std::endl;
			i += 2;
		}
	}
}

int
main(int argc, char **argv)
{
	bool use_asm = false;
	std::string input("");
	std::regex valid("^(o|re)+$");

	for (int i = 0; i < argc; ++i) {
		if (strncmp(argv[i], "--use_asm", 9) == 0) {
			use_asm = true;
		} else if (i != 0) {
			input = std::string(argv[i]);
		}
	}

	if (input[0] == '\0') {
		std::cout << "No input string specified" << std::endl;
		return 1;
	}

	if (!std::regex_match(input, valid)) {
		std::cout << "Input string invalid" << std::endl;
		return 2;
	}

	if (use_asm) {
		int max_len = input.length() * input.length() + input.length() + 1;
		char *output = new char[max_len];

		for (int i = 0; i < max_len; ++i) {
			output[i] = 'x';
		}

		oreo_asm((char *) input.c_str(), output);
		std::cout << output << std::endl;

		delete[] output;
	} else {
		oreo_c(input);
	}

	return 0;
}
