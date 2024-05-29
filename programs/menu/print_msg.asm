; This function prints first message passed in by caller
; 1st arg: Message to print

	section	.text
	global print_msg
	extern calc_str_length

print_msg:
	; Store string in r14 address
	mov	r14, rdi

	; Get str length
	call	calc_str_length
	mov	rdx, rax

	mov	rsi, rdi	; Move msg to second arg for write syscall

	mov	rax, 1
	mov	rdi, 1
	syscall
	ret
