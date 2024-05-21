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

### Assembling with nasm and ld:

```bash
nasm -felf64 PROGRAM_NAME
ld PROGRAM_NAME.o -o EXECUTABLE_NAME
```

* ```-felf64``` flag means to format the output file in ***elf64*** format (ELF64 (x86-64) (Linux, most Unix variants))

* ```ld``` - The GNU linker

### Assembling with nasm and gcc

* Better when using c standard library

```bash
nasm -felf64 add.asm
gcc -no-pie add.o -o add.out
```

## NASM program structure

Programs are made of two types of sections:
  * Directives
  * Sections

Each line in a program can be made of the following:
  * Label
  * Instruction
  * Operands

## Using ```objdump``` to view executable instructions

You can use the ```objdump``` command to view the assembly instructions used in an object file.


```add.c```
```c
#include <stdio.h>

int main() {
  int x, y, sum;
  x = 5;
  printf("Enter an integer for y: ");
  scanf("%d", &y);
  sum = x + y;
  printf("%d\n", sum);

  return 0;
}
```

```bash
gcc add.c
objdump -d a.out -M intel
```

* ```-d``` - disassemble
* ```-M``` - --disassembler-options=OPT Pass text OPT on to the disassembler

```txt
The following i386/x86-64 specific disassembler options are supported for use
with the -M switch (multiple options should be separated by commas):
  x86-64      Disassemble in 64bit mode
  i386        Disassemble in 32bit mode
  i8086       Disassemble in 16bit mode
  att         Display instruction in AT&T syntax
  intel       Display instruction in Intel syntax
  att-mnemonic
              Display instruction in AT&T mnemonic
  intel-mnemonic
              Display instruction in Intel mnemonic
  addr64      Assume 64bit address size
  addr32      Assume 32bit address size
  addr16      Assume 16bit address size
  data32      Assume 32bit data size
  data16      Assume 16bit data size
  suffix      Always display instruction suffix in AT&T syntax
  amd64       Display instruction in AMD64 ISA
  intel64     Display instruction in Intel64 ISA

```