all: a.out

main.o:	main.asm
	nasm -f elf64 -g main.asm

binary_search.o: binary_search.asm
	nasm -f elf64 -g binary_search.asm

a.out: main.o binary_search.o
	ld main.o binary_search.o
