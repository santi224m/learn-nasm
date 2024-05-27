		section	.data
drink_price:	dd	5	; $5 drinks
sandwich_price:	dd	8	; $8 sandwich

drink_total:	dd	4
sandwich_total:	dd	4
total_price:	dd	4

drink_msg:	db	'Drinks ..... $'
drink_msg_len:	dd	14
sandwich_msg:	db	'Sandwiches ..... $'
sandwich_msg_len:
		dd	18

prompt_drinks:	db	'How many drinks? '
prompt_drinks_len:
		dd	17
prompt_sandwiches:
		db	'How many sandwiches? '
prompt_sandwiches_len:
		dd	21

drink_total_msg:
		db	'Drink total: '
drink_total_msg_len:
		dd	13

		section	.bss
char:		resb	1	; Reserve 1 byte to print ascii char for price
count:		resb	4
drink_count:	resd	1
sandwich_count:	resd	1

		section	.text
		global	_start
		extern	print_msg
		extern print_int

_start:
		; Print drink msg
		mov	rdi, drink_msg
		mov	esi, [drink_msg_len]
		call	print_msg

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
		mov	rdi, sandwich_msg
		mov	esi, [sandwich_msg_len]
		call	print_msg

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

		; Prompt user for drinks
		mov	rdi, prompt_drinks
		mov	esi, [prompt_drinks_len]
		call	print_msg

		; Take in user input for drinks count
		mov	rax, 0
		mov	rdi, 0
		mov	esi, drink_count
		mov	rdx, 4
		syscall

		; Remove 48 from user input to remove ascii offset
		mov	r13d, [drink_count]
		movzx	r13d, r13b			; Get first char only (not newline)
		sub	r13d, 48
		mov	[drink_count], r13d

		; Prompt user for sandwiches
		mov	rax, 1
		mov	rdi, 1
		mov	rsi, prompt_sandwiches
		mov	edx, [prompt_sandwiches_len]
		syscall

		; Take in user input for sandwich count
		mov	rax, 0
		mov	rdi, 0
		mov	rsi, sandwich_count
		mov	rdx, 4
		syscall

		; Remove ascii offset from sandwich count
		mov	r13d, [sandwich_count]
		movzx	r13d, r13b
		sub	r13, 48
		mov	[sandwich_count], r13

		; Calculate drink total
		mov	r13d, [drink_count]
		mov	r14d, [drink_price]
		imul	r13d, r14d
		mov	[drink_total], r13d

		; Print newline
		mov	rax, 1
		mov	rdi, 1
		mov	r13, 10
		mov	[char], r13
		mov	rsi, char
		mov	rdx, 1
		syscall

		; Print drink total
		mov	rdi, drink_total_msg
		mov	esi, [drink_total_msg_len]
		call	print_msg

		mov	rdi, [drink_total]
		call	print_int

		; Exit
		mov	rax, 60
		mov	rdi, 0
		syscall
