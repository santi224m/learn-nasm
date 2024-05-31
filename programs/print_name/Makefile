all: a.out

print_name.o: print_name.asm
	nasm -f elf64 -g print_name.asm

calc_str_length.o:	../lib/calc_str_length.asm
	nasm -f elf64 -g ../lib/calc_str_length.asm -o calc_str_length.o

a.out: print_name.o calc_str_length.o
	ld print_name.o calc_str_length.o
