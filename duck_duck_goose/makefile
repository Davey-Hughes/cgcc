all: ddg

ddg: ddg.nasm
	nasm -f elf64 -o ddg.o ddg.nasm
	ld -o ddg ddg.o
	# rm -f ddg.o

clean:
	rm -f ddg
