# Learning x86-64 Assembly with NASM

This repository will record my learning to write x86 assembly language using NASM.

I will try to document all the resources I use so that anyone can follow along.

I should note that I have completed a college course in computer architecture, where I learned the basics of the 32-bit x86 instruction set.

**OS**: Debian GNU/Linux bookworm 12.5 x86_64

**CPU**: AMD Ryzen 5 2600

# Table of Contents

1. [Resources](#resources)
1. [What is x86-64](#what-is-x86-64)
1. [Data Type Sizes](#data-type-sizes)
1. [GAS Suffixes](#gas-suffixes)
1. [Instructions](#instructions)
    - [Data movement instructions](#data-movement-instructions)
    - [Arithmetic and Logic Instructions](#arithmetic-and-logic-instructions)
    - [Shift and Rotate Instructions](#shift-and-rotate-instructions)
    - [Control Flow Instructions](#control-flow-instructions)
    - [Comparison Instructions](#comparison-instructions)
    - [Conditional Jump Instructions](#conditional-jump-instructions)
    - [NASM Pseudo-Instructions](#nasm-pseudo-instructions)
1. [Registers](#registers)
1. [System Calls](#system-calls)
    - [File Descriptors (fd)](#file-descriptors-fd)
    - [Common syscalls](#common-syscalls)
1. [What is NASM](#what-is-nasm)
1. [Installing NASM](#installing-nasm)
1. [Assembling Programs](#assembling-programs)
1. [NASM Program Structure](#nasm-program-structure)
1. [Sections](#sections)
1. [Functions](#functions)
1. [Using `objdump` to View Executable Instructions](#using-objdump-to-view-executable-instructions)
1. [Debugging with ```gdb```](#debugging-with-gdb)
    - [Print integer value of a label](#print-integer-value-of-a-label)

## Resources

[x86-64 Assembly Language Programming with Ubuntu](http://www.egr.unlv.edu/~ed/assembly64.pdf)

[NASM Docs](https://www.nasm.us/doc/)

[AMD64 Architecture Programmer’s Manual Volumes 1-5](https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/40332.pdf)

[Linux System Call Table](https://www.chromium.org/chromium-os/developer-library/reference/linux-constants/syscalls/#x86_64-64-bit)

[NASM Tutorial](https://cs.lmu.edu/~ray/notes/nasmtutorial/)

[Endianness Explained](https://youtu.be/LxvFb63OOs8?si=wuDV4ffZSnP5MO8F)

[Data Structure Alignment and Endianness](https://youtu.be/zyGMyV955Rw?si=qbDc-tK6VwQLfTId)

[Stack Frame explanation](https://youtu.be/CRTR5ljBjPM?si=4p-Vg8xbww_M4FRP)

[ x86_64 Linux Assembly YouTube Playlist](https://youtube.com/playlist?list=PLetF-YjXm-sCH6FrTz4AQhfH6INDQvQSn&si=toV9gOHZ-j73TPxk)

[x86-64 Machine-Level Programming Paper](https://www.cs.cmu.edu/afs/cs/academic/class/15213-f09/www/misc/asm64-handout.pdf)

[x86-64-ABI PDF](https://gitlab.com/x86-psABIs/x86-64-ABI)

[Using FPU registers for floating point calculations](https://gist.github.com/nikAizuddin/0e307cac142792dcdeba)

[NASM Forum](https://forum.nasm.us/index.php?board=2.0)

## What is x86-64

* the dominant instruction format
* 64-bit version of the Intel instruction set
* maintains full backward compatibility with IA32
* developed by AMD
* supported by AMD (AMD64) and Intel (Intel64)
* Sometimes referred to as x64
* Complex Instruction Set Computing (CISC) CPU design
  * include wide variety of instructions
  * varying instructions sizes
  * wide range of addressing modes
  * in contrast to Reduced Instruction Set Computer (RISC)
* 16 general-purpose registers

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

## GAS Suffixes

```GAS``` - GNU Assembler

```word``` - The natural size with which a processor is handling data (the register size)
  * x86_64 is an extension of 32-bit x86
  * 32-bit x86 extended 16-bit architecture.
  * 16-bit architecture had word of 2 bytes (16 bits) so x86_64 also uses word of 2 bytes for backward compatibility

| GAS Suffix | Type | Size (Bytes) |
| ---------- | ---- | ------------ |
| b | Byte | 1 |
| w | Word | 2 |
| l | Double Word | 4 |
| q | Quad word | 8 |
| s | Single precision | 4 |
| d | Double precision | 8 |
| t | Extended precision | 16 |

## Instructions

* brackets ```[ ]``` indicate a memory address

### Data movement instructions

Primarily used for transferring data between registers, memory, and stack.

| Instruction | Syntax | Description | Example |
| ----------- | ------ | ----------- | ------- |
| mov | mov dest, src | Moves data from the source operand to the destination operand. | mov eax, ebx |
| movsx | movsx dest, src | Moves a byte or word from the source to the destination and sign-extends it to a larger size. | movsx rax, al |
| movzx | movzx dest, src | Moves a byte or word from the source to the destination and zero-extends it to a larger size. | movzx rax, al |
| movsxd | movsxd dest, src | Moves a double word from the source to the destination and sign-extends it to a quad word. | movsxd rax, eax |
| lea | lea D, [S] | Load effective address of S into D. | lea rdx, [rax] |

### Arithmetic and Logic Instructions

Perform arithmetic and bitwise operations.

| Instruction | Syntax | Description | Example |
| ----------- | ------ | ----------- | ------- |
| add | add op, op | Adds the second operand to the first. | add eax, ebx |
| sub | sub op, op | Subtracts the second operand from the first. | sub eax, ebx |
| imul | imul D, S | Multiplies D by S, storing result in D. | imul rdx, rax |
| idiv | idiv op | Divides the accumulator (AX, EAX, or RAX) by the operand, storing the quotient in the accumulator and the remainder in DX, EDX, or RDX. | idiv ebx |
| inc | inc op | Increments the operand by 1. | inc eax |
| dec | dec op | Decrements the operand by 1. | dec eax |
| neg | neg D | Negates D. | neg rax |
| not | not D | Computes the bitwise complement of D. | not rax |
| and | and op, op | Performs a bitwise AND on the operands. | and eax, ebx |
| or | or op, op | Performs a bitwise OR on the operands. | or eax, ebx |
| xor | xor op, op | Performs a bitwise XOR on the operands. | xor eax, ebx |

### Shift and Rotate Instructions

Manipulate bits by shifting or rotating them.

| Instruction | Syntax | Description | Example |
| ----------- | ------ | ----------- | ------- |
| sal | sal D, k | Performs left shift on D by k bits. (Same as shl) | sal rax, 2 |
| shl | shl D, k | Performs left shift on D by k bits. | shl rax, 2 |
| sar | sar D, k | Performs arithmetic right shift on D by k bits. | sar rax, 2 |
| shr | shr D, k | Performs logical right shift on D by k bits. | shr rax, 2 |

### Control Flow Instructions

Used for system-level operations and stack management.

| Instruction | Syntax | Description | Example |
| ----------- | ------ | ----------- | ------- |
| syscall | syscall | Triggers a system call handled by the OS kernel. | syscall |
| push | push src | Pushes the operand onto the stack. | push rax |
| pop | pop dest | Pops the top of the stack into the destination. | pop rax |

### Comparison Instructions

Set the flags in the FLAGS register based on the result of the comparison. 

| Instruction | Syntax | Description | Example |
| ----------- | ------ | ----------- | ------- |
| cmp | cmp op1, op2 | Compares two operands by subtracting op2 from op1. | cmp eax, ebx |
| test | test op1, op2 | Logically ANDs two operands and sets the flags. | test eax, eax |

### Conditional Jump Instructions

Perform jumps based on the state of the flags.

| Instruction | Syntax | Description | Example |
| ----------- | ------ | ----------- | ------- |
| je | je label | Jump if equal (zero flag set). | je equal_label |
| jne | jne label | Jump if not equal (zero flag clear). | jne notequal_label |
| jg | jg label | Jump if greater (signed). | jg greater_label |
| jge | jge label | Jump if greater or equal (signed). | jge greatereq_label |
| jl | jl label | Jump if less (signed). | jl less_label |
| jle | jle label | Jump if less or equal (signed). | jle lesseq_label |


### NASM Pseudo-Instructions

> Pseudo-instructions are things which, though not real x86 machine instructions, are used in the instruction field anyway because that's the most convenient place to put them. [(NASM Docs)](https://www.nasm.us/doc/nasmdoc3.html#section-3.2)

### ```.data``` section

| Instruction | Syntax | Description | Example |
| ----------- | ------ | ----------- | ------- |
| db | db value[, ...] | Defines one or more bytes. | db 'hello', 0x55 |
| dw | dw value[, ...] | Defines one or more word (2 bytes). | dw 0x1234, 'a', 'ab' |
| dd | dd value[, ...] | Defines one or more double word (4 bytes). | dd 0x12345678, 1.234567e20 |
| dq | dq value[, ...] | Defines one or more quad word (8 bytes). | dq 0x123456789abcdef0, 1.234567e20 |
| dt | dt value[, ...] | Defines one ten-byte floating point number. | dt 1.234567e20 |

### Terminating strings

* Must append ```0``` to terminate strings.

Ex:

Defining strings without terminating them

```asm
 str1:   db      'string 1'
 str2:   db      'string 2'
 str3:   db      'string 3'
```

Then when viewing ```str1``` in gdb, all strings where printed because there is no break between them (Did not terminate). 

```bash
0x402000 <str1>:	"string 1string 2string 3,"
```

Now when added ```0``` to terminate strings.

```asm
str1:   db      'string 1', 0
str2:   db      'string 2', 0
str3:   db      'string 3', 0
```

And when viewing in gdb

```bash
0x402000 <str1>:	"string 1"
```

### ```.bss``` section

| Instruction | Reservation Size |
| ----------- | ---------------- |
| resb | 8-bit variable(s) |
| resw | 16-bit variable(s) |
| resd | 32-bit variable(s) |
| resq | 64-bit variable(s) |
| resdq | 128-bit variable(s) |

**Examples**

| Label | instruction | Element Qty | Comment |
| ----- | ----------- | ----------- | ------- |
| bArr | resb | 10 | ; 10 element byte array |
| wArr | resw | 50 | ; 50 element word array |
| dArr | resd | 100 | ; 100 element double array |
| qArr | resq | 200 | ; 200 element quad array |

## Registers

* ```register``` - a temporary storage or working location built into the CPU
* Computations are typically performed by the CPU using registers
* Program counter is named ```rip```
  * [Program counter](https://en.wikipedia.org/wiki/Program_counter) is a register that indicates where a computer is in its program sequence
  * points to next instruction to be executed

![Registers Table](./img/Table_of_x86_Registers_svg.svg)

### 16 integer registers (64 bits wide)

* ```rsp``` holds a pointer to the top stack element
  * should not be used for data or other uses
* ```rbp``` is used as a base pointer during function calls
  * should not be used for data or other uses  
* when the lower bit portion of a 64-bit register is set, the upper bits are unaffected

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

* used to support 64-bit and 32-bit floating-point operations and Single Instruction Multiple Data (SIMD) instructions
* SIMD instructions allow a single instruction to be applied simultaneously to multiple data items
  * significant performance increase

* more recent X86-64 processors support 256-bit XMM registers

| 128 bits |
| -------- |
| XMM0 |
| XMM1 |
| XMM2 |
| XMM3 |
| XMM4 |
| XMM5 |
| XMM6 |
| XMM7 |
| XMM8 |
| XMM9 |
| XMM10 |
| XMM11 |
| XMM12 |
| XMM13 |
| XMM14 |
| XMM15 |

### Flags Register

* ```rFlags``` is used for status and CPU control information
  * updated by the CPU after each instruction
  * not directly accessible by programs

| Name | Symbol | Bit | Use |
| ---- | ------ | --- | --- |
| Carry | CF | 0 | indicate if the previous operation resulted in a carry |
| Parity | PF | 2 | indicate if the last byte has an even number of 1's |
| Adjust | AF | 4 | support Binary Coded Decimal operations |
| Zero | ZF | 6 | indicate if the previous operation resulted in a zero result |
| Sign | SF | 7 | indicate if the result of the previous operation resulted in a 1 in the most significant bit (indicating negative in the context of signed data) |
| Direction | DF | 10 | specify the direction (increment or decrement) for some string operations |
| Overflow | OF | 11 | indicate if the previous operation resulted in an overflow |

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

## What is NASM

```NASM``` - The Netwide Assembler

* An x86 and x86_64 assembler
  * reads an assembly language input file and converts the code into a machine language binary file (object file)
  * variable names and labels are converted into appropriate addresses
* Syntax is designed to be simple and easy to understand
* Supports all currently known x86 architectural extensions
* 2-clause BSD license

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
ld -g print_hello.o -o print_hello
./print_hello
```

* ```-f elf64``` - format the object code file in ***elf64*** format  (ELF64 (x86-64) (Linux, most Unix variants))

* ```ld``` - The GNU linker
  * combines one or more object files into a single executable file

To link more than one object file into one executable:
  * functions not in the current source file must be declared as ```extern```
  * global variables can be accessed using ```extern```

```bash
ld -g -o example main.o funcs.o
```

Use ```-l FILENAME.lst``` to genearate a list file
  * can be useful for debugging

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
    * instructions to the assembler
    * not translated into instructions for the CPU
    * Ex: ```global``` directive makes symbols public, allowing them to be visible to the linker and other modules
  * Sections
    * ```.data``` section
    * ```.bss``` section
    * ```.text``` section

Each line in a program can be made of the following:
  * Label
  * Instruction
  * Operands

```txt
label:    instruction operands        ; comment
```

## Sections

* All assembly programs have the following sections:
  * ```.data``` - initialized data is declared and defined
  * ```.bss``` - uninitialized data is declared
  * ```.text``` - Main program

## Functions

* **Stack Dynamic Local Variables** - local variables are created by allocating space on the stack and assigning these stack locations to the variables
  * If function with a large number of local variables is never called, the memory for the local variables is never allocated (helps overall performance of program)

* **statically declared variables** - assigned memory locations for the entire execution of the program
  * uses memory even if the associated function is not being executed
  * no additional run-time overhead

```asm
  global <procName>
<procName>:
  ; function body
  ret
```

* ```call``` - transfers control to the named function
  * Saves address of what line to return to when function is complete
  * Stores rip (instruction pointer) in stack (rsp)
* ```ret``` - returns control back to the calling routine
  * Pops top of stack (instruction to return to) to rip register
* within the function the stack must not be corrupted
  * any items pushed must be popped

### Passing arguments to and/or from a function

* Placing values in register
* Globally defined 
* Putting values and/or addresses on stack

* **function prologue** - code at the beginning of a function
  * helps save program state
  * This includes storing [registers](#registers) whos value is preserved ("Callee saved") accross functions calls
* **function epilogue** - code at the end of a function
  * restores the program state

### Parameter Passing

* First six integer arguments are passed in [registers](#registers)
  * additional arguments are passed on the stack

* Arguments passed on the stack should be pushed in reverse order
  * Stack is FIFO so you want first argument to be pushed last to pop it first

* floating-point arguments are passed in registers **xmm0** to **xmm7**

* when the function is completed, calling routine is responsible for clearing the arguments from the stack
  * stack pointer, ```rsp```, is adjusted as necessary to clear arguments off the stack
  * adding ```[(number of arguments) * 8]``` to the rsp

* Values are returned in **A** register

| Return Value Size | Register |
| ----------------- | -------- |
| byte | al |
| word | ax |
| double-word | eax |
| quadword | rax |
| floating-point | xmm0 |

## Using ```objdump``` to view executable instructions

* assembler converts each assembly language instruction into a set of 1's and 0's that the CPU knows to be that instruction
* one-to-one correspondence between assembly language instructions and binary machine language
* means executable file can be converted back into human readable assembly language
  * missing comments, variable names, and label names

You can use the ```objdump``` disassembler command to view the assembly instructions in an object file.

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
disassemblerrbp
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

## Debugging with ```gdb```

Add ```-g``` when assembling code to include symbols in executable

```bash
nasm -f elf64 -g filename.asm
```

* Start gdb with ```gdb```
* Enable ```tui``` to see code along with gdb debugger
* Use ```info registers``` to print registers
  * ```info registers rax``` to print a specific register (replace rax with register)

```bash
GNU gdb (Debian 13.1-3) 13.1
Copyright (C) 2023 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word".
(gdb) file a.out
Reading symbols from a.out...
(gdb) break 40
Breakpoint 1 at 0x401000: file menu.asm, line 40.
(gdb) run
Starting program: /home/santissj/Github/learn-nasm/asm/menu/a.out 

Breakpoint 1, _start () at menu.asm:40
40			mov	rax, 1
(gdb) info registers rax
rax            0x0                 0
(gdb) break 41
Breakpoint 2 at 0x401005: file menu.asm, line 41.
(gdb) c
Continuing.

Breakpoint 2, _start () at menu.asm:41
41			mov	rdi, 1
(gdb) info registers rax
rax            0x1                 1
(gdb)
```

### Print integer value of a label

Integer ```x``` set to ```5``` using ```dd``` pseudo-instruction

```bash
        section .data
x:      dd      5
```

In ```gdb```:

```bash
(gdb) info address x
Symbol "x" is at 0x402000 in a file compiled without debugging.
(gdb) x/d 0x402000
0x402000 <x>:	5

```

| Command | Description |
| ------- | ----------- |
| x/\<n>\<f>\<u> $\<register> | Examine contents of the stack. |
| x/\<n>\<f>\<u> &\<variable> | Examine memory location of \<variable> |

* ```n``` - Number of locations (1 is default)
* ```f``` - Format
  * ```d``` - decimal (signed)
  * ```x``` - hex
  * ```u``` - decimal (unsigned)
  * ```c``` - character
  * ```s``` - string
  * ```f``` - floating-point
* ```u``` - Unit size
  * ```b``` - byte (8 bits)
  * ```h``` - halfword (16 bits)
  * ```w``` - word (32 bits)
  * ```g``` - giant (64 bits)
