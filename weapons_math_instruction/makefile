CXXFLAGS := -O2 -Wall -Werror -Wpedantic

ASM_FILE ?= weapons.nasm

all: weapons

weapons: weapons.cc $(ASM_FILE)
	nasm -f elf64 -o weapons.o $(ASM_FILE)
	g++ $(CXXFLAGS) -o weapons weapons.o weapons.cc
	rm -f weapons.o

.PHONY: clean
clean:
	rm -f weapons.o weapons
