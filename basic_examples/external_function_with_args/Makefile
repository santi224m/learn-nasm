all: a.out

main.o:	main.asm
	nasm -f elf64 -g main.asm

print.o: print.asm
	nasm -f elf64 -g print.asm

exit.o:	exit.asm
	nasm -f elf64 -g exit.asm

a.out:	main.o print.o exit.o
	ld main.o print.o exit.o
