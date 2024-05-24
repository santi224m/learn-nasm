all: a.out

print_name.o: print_name.asm
	nasm -f elf64 -g print_name.asm

a.out: print_name.o
	ld print_name.o
