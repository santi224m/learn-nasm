all: a.out

hello.o: hello.asm
	nasm -f elf64 -g hello.asm

a.out:	hello.o
	ld hello.o
