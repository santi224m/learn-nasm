# Learning Assembly with NASM

This repository will record my learning to write x86 assembly language using NASM.

**OS**: Debian GNU/Linux bookworm 12.5 x86_64

Installing NASM

```bash
sudo apt install nasm
```

## Resources

[NASM Docs](https://www.nasm.us/doc/)
[NASM Tutorial](https://cs.lmu.edu/~ray/notes/nasmtutorial/)
[AMD64 Architecture Programmer’s Manual Volumes 1-5](https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/40332.pdf)

## Assembling Programs

```bash
nasm -felf64 PROGRAM_NAME
ld PROGRAM_NAME.o -o EXECUTABLE_NAME
```

```bash
NASM Option
-f format
	        Specifies the output file format.
		elf64    ELF64 (x86-64) (Linux, most Unix variants)
```

```bash
ld - The GNU linker
```

## NASM program structure

Programs are made of two types of sections:
  * Directives
  * Sections

Each line in a program can be made of the following:
  * Label
  * Instruction
  * Operands
