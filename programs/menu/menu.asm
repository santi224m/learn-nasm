		section	.data
drink_price:	dd	5	; $5 drinks
sandwich_price:	dd	8	; $8 sandwich

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
drink_count:	resd	1
sandwich_count:	resd	1

drink_total:	resd	1
sandwich_total:	resd	1
total_price:	resd	1

		section	.text
		global	_start
		extern	print_msg
		extern	print_int
		extern	print_nl

_start:
		; Print drink menu option
		mov	rdi, drink_msg
		call	print_msg
		mov	rdi, [drink_price]
		call	print_int

		; Print sandwich menu option
		mov	rdi, sandwich_msg
		call	print_msg
		mov	rdi, [sandwich_price]
		call	print_int

		; Prompt user for drinks
		mov	rdi, prompt_drinks
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
;		mov	rax, 1
;		mov	rdi, 1
;		mov	rsi, prompt_sandwiches
;		mov	edx, [prompt_sandwiches_len]
;		syscall

		mov	rdi, prompt_sandwiches
		call	print_msg

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
		mov	r13, [drink_count]
		mov	r14, [drink_price]
		imul	r13, r14
		mov	[drink_total], r13

		; Print drink total
		call	print_nl
		mov	rdi, drink_total_msg
		call	print_msg

		mov	rdi, [drink_total]
		call	print_int

		; Exit
		mov	rax, 60
		mov	rdi, 0
		syscall
