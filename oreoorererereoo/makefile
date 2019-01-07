CXXFLAGS := -O2 -Wall -Werror -Wpedantic
ASM_INLINE_FLAGS := -m64 -masm=intel -mtune=intel

ASM_FILE ?= oreo.nasm

all: oreo oreo_inline

oreo_inline: oreo_inline.cc
	g++ $(CXXFLAGS) $(ASM_INLINE_FLAGS) -o oreo_inline oreo_inline.cc

oreo: oreo.cc $(ASM_FILE)
	nasm -f elf64 -o oreo.o $(ASM_FILE)
	g++ $(CXXFLAGS) -o oreo oreo.o oreo.cc
	rm -f oreo.o

.PHONY: clean
clean:
	rm -f oreo.o oreo oreo_inline
