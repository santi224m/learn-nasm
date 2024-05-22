# Learning x86-64 Assembly with NASM

This repository will record my learning to write x86 assembly language using NASM.

I will try to document all the resources I use so that anyone can follow along.

I should note that I have completed a college course in computer architecture, where I learned the basics of the 32-bit x86 instruction set.

**OS**: Debian GNU/Linux bookworm 12.5 x86_64

**CPU**: AMD Ryzen 5 2600

# Table of Contents

1. [Resources](#resources)
1. [What is x86-64](#what-is-x86-64)
1. [Installing NASM](#installing-nasm)
1. [Assembling Programs](#assembling-programs)
1. [NASM Program Structure](#nasm-program-structure)
1. [Sections](#sections)
1. [Instructions](#instructions)
1. [Registers](#registers)
1. [System Calls](#system-calls)
    - [File Descriptors (fd)](#file-descriptors-fd)
    - [Common syscalls](#common-syscalls)
1. [Data Type Sizes](#data-type-sizes)
1. [Using `objdump` to View Executable Instructions](#using-objdump-to-view-executable-instructions)

## Resources

[NASM Docs](https://www.nasm.us/doc/)

[AMD64 Architecture Programmer’s Manual Volumes 1-5](https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/40332.pdf)

[Linux System Call Table](https://www.chromium.org/chromium-os/developer-library/reference/linux-constants/syscalls/#x86_64-64-bit)

[NASM Tutorial](https://cs.lmu.edu/~ray/notes/nasmtutorial/)

[ x86_64 Linux Assembly YouTube Playlist](https://youtube.com/playlist?list=PLetF-YjXm-sCH6FrTz4AQhfH6INDQvQSn&si=toV9gOHZ-j73TPxk)

[x86-64 Machine-Level Programming Paper](https://www.cs.cmu.edu/afs/cs/academic/class/15213-f09/www/misc/asm64-handout.pdf)

[x86-64-ABI PDF](https://gitlab.com/x86-psABIs/x86-64-ABI)

## What is x86-64

* the dominant instruction format
* 64-bit version of the Intel instruction set
* maintains full backward compatibility with IA32
* developed by AMD
* supported by AMD (AMD64) and Intel (Intel64)
* Sometimes referred to as x64
* 16 general-purpose registers

## Installing NASM

```bash
sudo apt install nasm
```


## Assembling Programs

Example program to compile


```print_hello.asm```
```asm
	section .data
msg:	db	"Enter your name: "	; 17 bytes
hello_msg: db	"Hello, "		; 7 bytes
name:	db	15			; 15 bytes

	section	.text
	global _start

_start:	; Prompt user for name
	mov rax, 1
	mov rdi, 1
	mov rsi, msg
	mov rdx, 17
	syscall

	; Get name from user
	mov rax, 0
	mov rdi, 0
	mov rsi, name
	mov rdx, 15
	syscall

	; Say hello to user
	mov rax, 1
	mov rdi, 1
	mov rsi, hello_msg
	mov rdx, 7
	syscall

	mov rax, 1
	mov rdi, 1
	mov rsi, name
	mov rdx, 15
	syscall

	; Exit program
	mov rax, 60
	mov rdi, 0
	syscall

```

### Assembling with nasm and ld

```bash
nasm -f elf64 print_hello.asm
ld print_hello.o -o print_hello
./print_hello
```

* ```-f elf64``` - format the object code file in ***elf64*** format (ELF64 (x86-64) (Linux, most Unix variants))

* ```ld``` - The GNU linker

### Assembling with nasm and gcc

* Better when using c standard library
* **Note**: To assemble ```print_hello.asm``` program above with gcc, you must replace ```_start``` label with ```main```

```bash
nasm -f elf64 print_hello.asm
gcc -no-pie print_hello.o -o print_hello
./print_hello
```

## NASM program structure

Programs are made of two types of sections:
  * Directives
  * Sections

Each line in a program can be made of the following:
  * Label
  * Instruction
  * Operands

## Sections

* All assembly programs have the following sections:
  * ```.data``` - Where all data is defined before compilation
  * ```.bss``` - Where data is allocated for future use
  * ```.text``` - Main program

## Instructions

* ```mov a, b``` - Move b to a
* ```and a, b``` - a AND b stored at a
* ```or a, b``` - a OR b stored at a
* ```xor a, b``` - a XOR b stored at a
* ```add a, b``` - Add a and b; Store at a
* ```sub a, b``` - Subtract a - b; Store at a
* ```inc a``` - Increment a
* ```dec a``` - Decrement a
* ```syscall n``` - Call OS routine n
* ```db``` - Declares bytes that will be in memory when the program runs (pseudo-instruction)

### Pseudo-Instructions for declaring initialized data

```txt
      db    0x55                ; just the byte 0x55 
      db    0x55,0x56,0x57      ; three bytes in succession 
      db    'a',0x55            ; character constants are OK 
      db    'hello',13,10,'$'   ; so are string constants 
      dw    0x1234              ; 0x34 0x12 
      dw    'a'                 ; 0x61 0x00 (it's just a number) 
      dw    'ab'                ; 0x61 0x62 (character constant) 
      dw    'abc'               ; 0x61 0x62 0x63 0x00 (string) 
      dd    0x12345678          ; 0x78 0x56 0x34 0x12 
      dd    1.234567e20         ; floating-point constant 
      dq    0x123456789abcdef0  ; eight byte constant 
      dq    1.234567e20         ; double-precision float 
      dt    1.234567e20         ; extended-precision float
```

## Registers

![Registers Table](./assets/Table_of_x86_Registers_svg.svg)

### 16 integer registers (64 bits wide)

| Full 64 bits | Lowest 32-bits | Lowest 16-bits | Highest 8-bits | Lowest 8-bits | Notes |
| ------------ | -------------- | -------------- | -------------- | ------------- | ----- |
| rax | eax | ax | ah | al | Return value |
| rbx | ebx | bx | bh | bl | Callee saved |
| rcx | ecx | cx | ch | cl | 4th argument |
| rdx | edx | dx | dh | dl | 3rd argument |
| rsi | esi | si | | sil | 2nd argument |
| rdi | edi | di | | dil | 1st argument |
| rbp | ebp | bp | | bpl | Callee saved |
| rsp | esp | sp | | spl | Stack pointer |
| r8 | r8d | r8w | | r8b | 5th argument |
| r9 | r9d | r9w | | r9b | 6th argument |
| r10 | r10d |  r10w | | r10b | Callee saved |
| r11 | r11d | r11w | | r11b | Used for linking |
| r12 | r12d | r12w | | r12b | Unused for C |
| r13 | r13d | r13w | | r13b | Callee saved |
| r14 | r14d | r14w | | r14b | Callee saved |
| r15 | r15d | r15w | | r15b | Callee saved |

### 16 XMM registers (128 bits wide)

```txt
XMM0
XMM1
XMM2
XMM3
XMM4
XMM5
XMM6
XMM7
XMM8
XMM9
XMM10
XMM11
XMM12
XMM13
XMM14
XMM15
```

## System Calls

* System calls are when program requests service from kernel.

* Each syscall has an ID

* See [Linux System Call Table](https://www.chromium.org/chromium-os/developer-library/reference/linux-constants/syscalls/#x86_64-64-bit) for list of all Linux system calls with their IDs and arguments

* Registers for system call ID and arguments:

| Argument | Register |
| -------- | --------- |
| ID | rax |
| 1 | rdi |
| 2 | rsi |
| 3 | rdx |
| 4 | r10 |
| 5 | r8 |
| 6 | r9 |


### File Descriptors (fd)

| Integer | Description |
| ------- | ----------- |
| 0 | Standard Input |
| 1 | Standard Output |
| 2 | Standard Error |

### Common syscalls

| # | syscall | rax | rdi | rsi | rdx | r10 | r8 | r9 |
| - | ------- | --- | --- | --- | --- | --- | -- | -- |
| 0 | read | 0 | unsigned int fd | char *buf | size_t count | - | - | - |
| 1 | write | 1 | unsigned int fd | const char *buf | size_t count | - | - | - |
| 60 | exit | 60 | int error_code | - | - | - | - | - |

## Argument register overview

| Argument type | Registers |
| ------------- | --------- |
| Integer/pointer arguments 1-6 | RDI, RSI, RDX, RCX, R8, R9  |
| Floating point arguments 1-8  | XMM0 - XMM7 |
| Excess arguments | Stack |
| Static chain pointer  | R10 |

## Data Type Sizes

| C type | Processor type | GAS suffix | x86-64 Size (Bytes) |
| ------ | -------------- | ---------- | ------------------- |
| char | Byte | b | 1 |
| short | Word | w | 2 |
| int | Double Word | l | 4 |
| unsigned | Double word | l | 4|
| long int | Quad word | q | 8 |
| unsigned long | Quad word | q | 8 |
| char * | Quad word | q | 8 |
| float | Single precision | s | 4 |
| double | Double precision | d | 8 |
| long double | Extended precision | t | 16 |

## Using ```objdump``` to view executable instructions

You can use the ```objdump``` command to view the assembly instructions in an object file.

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

Ouput of running ```objdump -d a.out -M intel```

```bash
// Rest of output

0000000000001149 <main>:
    1149:	55                   	push   rbp
    114a:	48 89 e5             	mov    rbp,rsp
    114d:	48 83 ec 10          	sub    rsp,0x10
    1151:	c7 45 fc 05 00 00 00 	mov    DWORD PTR [rbp-0x4],0x5
    1158:	48 8d 05 a5 0e 00 00 	lea    rax,[rip+0xea5]        # 2004 <_IO_stdin_used+0x4>
    115f:	48 89 c7             	mov    rdi,rax
    1162:	b8 00 00 00 00       	mov    eax,0x0
    1167:	e8 c4 fe ff ff       	call   1030 <printf@plt>
    116c:	48 8d 45 f4          	lea    rax,[rbp-0xc]
    1170:	48 89 c6             	mov    rsi,rax
    1173:	48 8d 05 a3 0e 00 00 	lea    rax,[rip+0xea3]        # 201d <_IO_stdin_used+0x1d>
    117a:	48 89 c7             	mov    rdi,rax
    117d:	b8 00 00 00 00       	mov    eax,0x0
    1182:	e8 b9 fe ff ff       	call   1040 <__isoc99_scanf@plt>
    1187:	8b 55 f4             	mov    edx,DWORD PTR [rbp-0xc]
    118a:	8b 45 fc             	mov    eax,DWORD PTR [rbp-0x4]
    118d:	01 d0                	add    eax,edx
    118f:	89 45 f8             	mov    DWORD PTR [rbp-0x8],eax
    1192:	8b 45 f8             	mov    eax,DWORD PTR [rbp-0x8]
    1195:	89 c6                	mov    esi,eax
    1197:	48 8d 05 82 0e 00 00 	lea    rax,[rip+0xe82]        # 2020 <_IO_stdin_used+0x20>
    119e:	48 89 c7             	mov    rdi,rax
    11a1:	b8 00 00 00 00       	mov    eax,0x0
    11a6:	e8 85 fe ff ff       	call   1030 <printf@plt>
    11ab:	b8 00 00 00 00       	mov    eax,0x0
    11b0:	c9                   	leave
    11b1:	c3                   	ret

// Rest of output
```