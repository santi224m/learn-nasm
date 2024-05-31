	section .data
msg:	db	"Enter your name (32 chars max): ", 0
hello_msg: db	"Hello, ", 0

	section	.bss
name:	resd	1

	section	.text
	global	_start
	extern	calc_str_length

_start:	; Prompt user for name
	mov	rdi, msg
	call	calc_str_length
	mov	rdx, rax
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, msg
	syscall

	; Get name from user (32 chars max)
	mov	rax, 0
	mov	rdi, 0
	mov	rsi, name
	mov	rdx, 0x20
	syscall

	; Say hello to user
	mov	rdi, hello_msg
	call	calc_str_length
	mov	rdx, rax
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, hello_msg
	syscall

	; Print name
	mov	rdi, name
	call	calc_str_length
	mov	rdx, rax
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, name
	syscall

	; Exit program
	mov	rax, 60
	mov	rdi, 0
	syscall
