all: mult_table mult_table2

mult_table: mult_table.nasm
	nasm -f elf64 -o mult_table.o mult_table.nasm
	ld -o mult_table mult_table.o
	rm -f mult_table.o

mult_table2: mult_table2.nasm
	nasm -f elf63 -o mult_table2.o mult_table2.nasm
	ld -o mult_table2 mult_table2.o
	rm -f mult_table2.o

clean:
	rm -f mult_table mult_table2
