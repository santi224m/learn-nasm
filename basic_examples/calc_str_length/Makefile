all:	a.out

calc_str_length.o:	calc_str_length.asm
	nasm -f elf64 -g calc_str_length.asm

a.out:	calc_str_length.o
	ld calc_str_length.o
