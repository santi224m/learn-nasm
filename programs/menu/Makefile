all: a.out

menu.o:	menu.asm
	nasm -f elf64 -g menu.asm

print_msg.o: print_msg.asm
	nasm -f elf64 -g print_msg.asm

print_int.o:	print_int.asm
	nasm -f elf64 -g print_int.asm

print_nl.o:	print_nl.asm
	nasm -f elf64 -g print_nl.asm

a.out: menu.o print_msg.o print_int.o print_nl.o
	ld menu.o print_msg.o print_int.o print_nl.o
