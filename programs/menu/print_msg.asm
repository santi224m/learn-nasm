; This function prints first message passed in by caller
; 1st arg: Message to print

	section	.text
	global print_msg
	extern calc_str_length

print_msg:
	; Preserve rbx
	push	rbp
	mov	rbp, rsp
	sub	rsp, 0x40
	mov	[rsp-0x40], rbx

	mov	rbx, rdi	; Store string in rbx address

	; Get str length
	call	calc_str_length
	mov	rdx, rax	; Store string length as 3rd arg

	mov	rsi, rbx	; Move msg to second arg for write syscall

	; Call write system call
	mov	rax, 1
	mov	rdi, 1
	syscall
	; Restore rbx
	mov	rbx, [rsp-0x40]
	add	rsp, 0x40
	pop	rbp
	ret
