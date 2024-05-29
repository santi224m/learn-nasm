; This code demonstrates how to preserve register values when calling a
; function that uses that register.
; The function code should store the register value in the function prologue
; and restore the value to the register in the function epilogue.
; The value is stored in the stack
; See useRBX.asm for how this works

	section	.bss
mychar:	resb	1	; Reserve 1 byte to use to print a char

	section	.text
	global	_start
	extern useRBX

_start:
	; rbx register is preserved through calls
	mov	rbx, 65		; ascii: 'A'

	; Call function that uses rbx
	call	useRBX

	; Print char stored at rbx (should still be 65/'A')
	mov	rax, 1
	mov	rdi, 1
	mov	[mychar], rbx
	mov	rsi, mychar
	mov	rdx, 1
	syscall

	; Exit
	mov	rax, 60
	mov	rdi, 0
	syscall
