all: div

div: div.c
	gcc -std=gnu11 -masm=intel -mtune=intel -O2 -o div div.c

clean:
	rm -f div
