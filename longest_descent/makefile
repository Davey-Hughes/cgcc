CXXFLAGS := -O2 -Wall -Werror -Wpedantic

all: descent gen_grid

descent: descent.nasm descent.cc
	nasm -f elf64 -o descent.o descent.nasm
	g++ $(CXXFLAGS) -o descent descent.o descent.cc
	rm descent.o

gen_grid: gen_grid.cc
	g++ $(CXXFLAGS) -o gen_grid gen_grid.cc

clean:
	rm -f descent gen_grid
