/* https://codegolf.stackexchange.com/questions/178344/oreoorererereoo */

#include <iostream>
#include <regex>

#include <string.h>

void
oreo_asm(char *input, char *output)
{
	asm (
		"       push    rsi\n"
		"       push    rdi\n"
		"len:\n"
		"       inc     rdi\n"
		"       cmp     BYTE PTR [rdi], 0x0\n"
		"       jne     len\n"
		"       mov     r12, rdi\n"
		"       pop     rdi\n"
		"       sub     r12, rdi\n"
		"       xor     r14, r14\n"
		"       jmp     outer_loop.skip\n"
		"extra:\n"
		"       mov     BYTE PTR [r9], 0x20\n"
		"       mov     BYTE PTR [rbx], 0x20\n"
		"       dec     r14\n"
		"       jmp     outer_loop\n"
		"newline:\n"
		"       mov     BYTE PTR [rsi], 0xa\n"
		"       inc     rsi\n"
		"outer_loop:\n"
		"       inc     r14\n"
		"       inc     rdi\n"
		"outer_loop.skip:\n"
		"       mov     r8b, BYTE PTR [rdi]\n"
		"       cmp     r8b, 0x65\n"
		"       je      extra\n"
		"       test    r8b, r8b\n"
		"       je      done\n"
		"       mov     rbx, rsi\n"
		"inner_loop:\n"
		"       mov     BYTE PTR [rsi], r8b\n"
		"       mov     r9, rsi\n"
		"       inc     rsi\n"
		"       xor     rdx, rdx\n"
		"       mov     rax, rsi\n"
		"       sub     rax, QWORD PTR [rsp]\n"
		"       sub     rax, r14\n"
		"       div     r12\n"
		"       test    rdx, rdx\n"
		"       je      newline\n"
		"       jmp     inner_loop\n"
		"done:\n"
		"       pop     rsi\n"
		: /* no outputs */
		: "rsi" (output), "rdi" (input)
		: "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15",
		  "rax", "rbx", "rcx", "rdx"
	);
}


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
			std::cout << std::string(input.length() - 2, 'r');
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
			output[i] = '\0';
		}

		oreo_asm((char *) input.c_str(), output);
		std::cout << output;

		delete[] output;
	} else {
		oreo_c(input);
	}

	return 0;
}
