CXXFLAGS := -O2 -Wall -Werror -Wpedantic

ASM_FILE ?= oreo.nasm

all: oreo

oreo: oreo.cc $(ASM_FILE)
	nasm -f elf64 -o oreo.o $(ASM_FILE)
	g++ $(CXXFLAGS) -o oreo oreo.o oreo.cc
	rm -f oreo.o

.PHONY: clean
clean:
	rm -f oreo.o oreo
