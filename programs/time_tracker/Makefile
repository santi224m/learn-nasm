all:	a.out

time_tracker.o:	time_tracker.asm
	nasm -f elf64 -g time_tracker.asm

print_msg.o:	../lib/print_msg.asm
	nasm -f elf64 -g ../lib/print_msg.asm -o print_msg.o

calc_str_length.o:	../lib/calc_str_length.asm
	nasm -f elf64 -g ../lib/calc_str_length.asm -o calc_str_length.o

get_int.o:	../lib/get_int.asm
	nasm -f elf64 -g ../lib/get_int.asm -o get_int.o

print_int.o:	../lib/print_int.asm
	nasm -f elf64 -g ../lib/print_int.asm -o print_int.o

print_nl.o:	../lib/print_nl.asm
	nasm -f elf64 -g ../lib/print_nl.asm -o print_nl.o

a.out:	time_tracker.o print_msg.o calc_str_length.o get_int.o print_int.o print_nl.o
	ld time_tracker.o print_msg.o calc_str_length.o get_int.o print_int.o print_nl.o
