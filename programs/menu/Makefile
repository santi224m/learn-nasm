all: menu.out

menu.o:	menu.asm
	nasm -felf64 -g menu.asm

menu.out: menu.o
	ld menu.o
