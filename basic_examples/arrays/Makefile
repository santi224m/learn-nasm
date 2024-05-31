all:	a.out

arrays.o:	arrays.asm
	nasm -f elf64 -g arrays.asm

print_int.o:	../lib/print_int.asm
	nasm -f elf64 -g ../lib/print_int.asm -o print_int.o

print_nl.o:	../lib/print_nl.asm
	nasm -f elf64 -g ../lib/print_nl.asm -o print_nl.o

a.out:	arrays.o print_int.o print_nl.o
	ld arrays.o print_int.o print_nl.o
