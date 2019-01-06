CXXFLAGS := -O2 -Wall -Werror -Wpedantic

all: oreo

oreo: oreo.cc oreo.nasm
	nasm -f elf64 -o oreo.o oreo.nasm
	g++ $(CXXFLAGS) -o oreo oreo.o oreo.cc
	rm -f oreo.o

clean:
	rm -f oreo.o oreo
