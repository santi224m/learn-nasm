all:	a.out

string_iteration.o:	string_iteration.asm
	nasm -f elf64 -g string_iteration.asm

a.out:	string_iteration.o
	ld string_iteration.o
