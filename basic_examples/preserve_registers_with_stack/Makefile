all:	a.out

main.o:	main.asm
	nasm -f elf64 -g main.asm

useRBX.o: useRBX.asm
	nasm -f elf64 -g useRBX.asm

a.out:	main.o useRBX.o
	ld main.o useRBX.o
