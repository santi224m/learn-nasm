all:	a.out


using_stack.o:	using_stack.asm
	nasm -f elf64 -g using_stack.asm

a.out:	using_stack.o
	ld using_stack.o
