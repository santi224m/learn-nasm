; To assemble and run:
; nasm -felf64 hello.asm
; ld hello.o -o hello.out
; ./hello.out

; Directives
; Instuction: global
; Operand: _start

global _start

; Sections
; Instruction: section
; Operand: .text

section .text

; Label: start:
; Instruction: mov
; Operands: rax, 1

_start: mov rax, 1
mov rdi, 1
mov rsi, message
mov rdx, 13
syscall
mov rax, 60
xor rdi, rdi
syscall

section .data
message: db "Hello, World", 10
