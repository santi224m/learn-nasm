		section	.data
drink_price:	dd	5	; $5 drinks
sandwich_price:	dd	8	; $8 sandwich

drink_count:	db	4
sandwich_count:	db	4

drink_msg:	db	'Drinks ..... $'
drink_msg_len:	dd	14
sandwich_msg:	db	'Sandwiches ..... $'
sandwich_msg_len:
		dd	18

		section	.bss
char:		resb	1	; Reserve 1 byte to print ascii char for price

		section	.text
		global	_start

_start:
		; Print drink msg
		mov	rax, 1
		mov	rdi, 1
		mov	rsi, drink_msg
		mov	edx, [drink_msg_len]
		syscall

		; Store ascii value of drink_price in char
		mov	r13, [drink_price]
		add	r13, 0x30
		mov	[char], r13

		; Print drink price
		mov	rax, 1
		mov	rdi, 1
		mov	rsi, char
		mov	rdx, 1
		syscall

		; Print newline
		mov	rax, 1
		mov	rdi, 1
		mov	r13, 10
		mov	[char], r13
		mov	rsi, char
		mov	rdx, 1
		syscall

		; Print sandwich msg
		mov	rax, 1
		mov	rdi, 1
		mov	rsi, sandwich_msg
		mov	edx, [sandwich_msg_len]
		syscall

		; Print sandwich price
		mov	rax, 1
		mov	rdi, 1
		mov	r13, [sandwich_price]
		add	r13, 0x30
		mov	[char], r13
		mov	rsi, char
		mov	rdx, 1
		syscall

		; Print newline
		mov	rax, 1
		mov	rdi, 1
		mov	r13, 10
		mov	[char], r13
		mov	rsi, char
		mov	rdx, 1
		syscall

		; Exit
		mov	rax, 60
		mov	rdi, 0
		syscall
