all: a.out

main.o:	main.asm
	nasm -f elf64 -g main.asm

print.o: print.asm
	nasm -f elf64 -g print.asm

a.out:	main.o print.o
	ld main.o print.o
