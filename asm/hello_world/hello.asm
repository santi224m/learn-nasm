	section	.data
message:
	db	"Hello, World!", 10	; Define message to print


	section .text
	global _start

_start:
	; Print message using write system call
	mov rax, 1
	mov rdi, 1
	mov rsi, message
	mov rdx, 14
	syscall

	; Exit program
	mov rax, 60
	xor rdi, rdi
	syscall

