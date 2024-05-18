all: add.out

add.o:	add.asm
	nasm -felf64 add.asm

add.out:	add.o
	gcc -no-pie add.o -o add.out
