all: menu.out

menu.o:	menu.asm
	nasm -f elf64 -g menu.asm

menu.out: menu.o print_msg.o
	ld menu.o print_msg.o

print_msg.o: print_msg.asm
	nasm -f elf64 -g print_msg.asm
