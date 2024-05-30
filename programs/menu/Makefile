all: a.out

menu.o:	menu.asm
	nasm -f elf64 -g menu.asm

print_msg.o: print_msg.asm
	nasm -f elf64 -g print_msg.asm

print_int.o:	print_int.asm
	nasm -f elf64 -g print_int.asm

print_nl.o:	print_nl.asm
	nasm -f elf64 -g print_nl.asm

calc_str_length.o:	calc_str_length.asm
	nasm -f elf64 -g calc_str_length.asm

get_user_input.o:	get_user_input.asm
	nasm -f elf64 -g get_user_input.asm

a.out: menu.o print_msg.o print_int.o print_nl.o calc_str_length.o get_user_input.o
	ld menu.o print_msg.o print_int.o print_nl.o calc_str_length.o get_user_input.o
