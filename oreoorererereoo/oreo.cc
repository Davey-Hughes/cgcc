/* https://codegolf.stackexchange.com/questions/178344/oreoorererereoo */

#include <iostream>
#include <regex>

#include <string.h>

extern "C" void oreo_asm(char *);

void
oreo_c(char *input)
{
	std::cout << input << std::endl;
}

int
main(int argc, char **argv)
{
	bool use_asm = false;
	char *input = (char *) "";
	std::regex valid("^(o|re)+$");

	for (int i = 0; i < argc; ++i) {
		if (strncmp(argv[i], "--use_asm", 9) == 0) {
			use_asm = true;
		} else if (i != 0) {
			input = argv[i];
		}
	}

	if (*input == '\0') {
		std::cout << "No input string specified" << std::endl;
		return 1;
	}

	if (!std::regex_match(std::string(input), valid)) {
		std::cout << "Input string invalid" << std::endl;
		return 2;
	}

	if (use_asm) {
		oreo_asm(input);
	} else {
		oreo_c(input);
	}

	return 0;
}
