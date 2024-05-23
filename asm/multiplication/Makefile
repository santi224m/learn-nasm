all:	a.out

multiplication.o:	multiplication.asm
	nasm -f elf64 -g multiplication.asm

a.out:	multiplication.o
	ld multiplication.o
