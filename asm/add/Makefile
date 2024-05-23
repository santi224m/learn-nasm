all: a.out

addition.o:	addition.asm
	nasm -f elf64 -g addition.asm

a.out:	addition.o
	ld addition.o
