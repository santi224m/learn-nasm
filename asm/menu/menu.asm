		section	.data
drink_price:	dd	5	; $5 drinks
sandwich_price:	dd	8	; $8 sandwich

drink_total:	dd	4
sandwich_total:	dd	4
total_price:	dd	4

drink_count:	db	4
sandwich_count:	db	4

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

		; Prompt user for drinks
		mov	rax, 1
		mov	rdi, 1
		mov	rsi, prompt_drinks
		mov	edx, [prompt_drinks_len]
		syscall

		; Take in user input for drinks count
		mov	rax, 0
		mov	rdi, 0
		mov	rsi, drink_count
		mov	rdx, 4
		syscall

		; Remove 48 from user input to remove ascii offset
		mov	r13, [drink_count]
		sub	r13, 48
		mov	[drink_count], r13

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
		mov	r13, [sandwich_count]
		sub	r13, 48
		mov	[sandwich_count], r13

		; Calculate drink total
		mov	r13, [drink_count]
		mov	r14, 5
		imul	r13, r14
		mov	[drink_total], r13

		; Print newline
		mov	rax, 1
		mov	rdi, 1
		mov	r13, 10
		mov	[char], r13
		mov	rsi, char
		mov	rdx, 1
		syscall

		; Print drink total
		mov	rax, 1
		mov	rdi, 1
		mov	rsi, drink_total_msg
		mov	edx, [drink_total_msg_len]
		syscall

		mov	rax, 1
		mov	rdi, 1
		mov	r13, [drink_total]
		add	r13, 0x30
		mov 	[char], r13
		mov	rsi, char
		mov	rdx, 1
		syscall

		; Exit
		mov	rax, 60
		mov	rdi, 0
		syscall
