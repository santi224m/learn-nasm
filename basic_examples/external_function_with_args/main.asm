	section	.data
msg:	db	'Hello, World', 10
msg_size:
	dd	13

	section	.text
	global	_start
	extern	print_func		; Import print_func
	extern	exit

_start:
	mov	rdi, msg		; Pass msg as first argument
	mov	rsi, [msg_size]		; Pass msg size (bytes) as second argument
	call	print_func		; Call imported print_func

	; Exit program
	call exit			; Call imported exit function
