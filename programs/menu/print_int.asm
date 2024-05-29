; Print integer to console

	section	.bss
intchar:
	resb	1
myint:	resd	1

	section	.text
	global	print_int
	extern	print_nl

print_int:
	mov	[myint], rdi
	mov	rdx, 0
	mov	r12d, 0		; Counter for numbers in stack
	mov	r15d, 10	; Divisor

loop:	; Push all digits to stack
	mov	eax, [myint]
	div	r15d		; Divide myint by 10 to get rightmost digit

	push	rdx		; Rightmost digit is remainder; Push to stack
	mov	rdx, 0		; Clear rdx
	inc	r12d

	; Update myint
	mov	[myint], eax

	; Exit if eax is 0 (means we added all digits to stack)
	cmp	eax, 0
	Je	loop2init
	Jmp	loop

loop2init:	; Print each digit in the stack to the console
	mov	r15d, 0		; Counter for digits printed

loop2:
	cmp	r15d, r12d	; Exit once all digits have been printed
	Je return

	; Get next digit in stack
	pop	rax
	add	rax, '0'	; Add ascii offset
	mov	[intchar], rax

	; Print digit to console
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, intchar
	mov	rdx, 1
	syscall

	inc	r15d
	Jmp loop2

return:
	call	print_nl
	ret
