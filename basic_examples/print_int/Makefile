all:		a.out

print_int.o:	print_int.asm
	nasm -f elf64 -g print_int.asm

a.out:		print_int.o
	ld print_int.o
