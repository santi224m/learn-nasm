; Show how to iterate over a string by printing one character at time, each on a new line

	section	.data
str:	db	'banana', 10	; String to iterate over
str_len:
	dd	7
nl:	db	'', 10		; Newline

	section	.bss
mychar:	resb	1		; Char holder

	section	.text
	global	_start

_start:
	mov	r15d, 0		; counter

loop:
	; Exit if counter is equal to str length - 1
	mov	r14d, [str_len]
	dec	r14d
	cmp	r14d, r15d
	Je	exit

	; Move next char to mychar
	mov	r13, [str+r15d]		; Move start of string to next char
	movzx	r13, r13b		; Store next char in mychar
	mov	[mychar], r13

	; Print mychar
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, mychar
	mov	rdx, 1
	syscall

	; Print newline
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, nl
	mov	rdx, 1
	syscall

	; Increment counter
	inc	r15d
	jmp	loop

exit:	; Exit
	mov	rax, 60
	mov	rdi, 0
	syscall
