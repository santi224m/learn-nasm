; This function prints first message passed in by caller
; 1st arg: Message to print
; 2nd arg: Size of message (bytes)

	section	.text
	global print_msg

print_msg:
	mov	rdx, rsi	; Move size to third arg for write syscall
	mov	rsi, rdi	; Move msg to second arg for write syscall

	mov	rax, 1
	mov	rdi, 1
	syscall
	ret
