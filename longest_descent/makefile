all: descent

descent: descent.nasm descent.cc
	nasm -f elf64 -o descent.o descent.nasm
	g++ -O2 -Wall -Werror -Wpedantic -o descent descent.o descent.cc
	rm descent.o

clean:
	rm -f descent
