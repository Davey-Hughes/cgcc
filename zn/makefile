CXXFLAGS := -O2 -Wall -Werror -Wpedantic

ASM_FILE ?= zn.nasm

all: zn

zn: zn.cc $(ASM_FILE)
	nasm -f elf64 -o zn.o $(ASM_FILE)
	g++ $(CXXFLAGS) -o zn zn.o zn.cc
	rm -f zn.o

.PHONY: clean
clean:
	rm -f zn.o zn
