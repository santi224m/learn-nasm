; Show how stack works (Li-Fo)

	section	.data
x_str:	db	'x: '
y_str:	db	'y: '
z_str:	db	'z: '
nl:	db	'', 10

	section	.bss
x:	resd	1
y:	resd	1
z:	resd	1
numchar:
	resb	1

	section	.text
	global	_start

_start:
	; Push [2,4,6] to stack
	push	2
	push	4
	push	6

	; Pop top num and store in x (should be 6)
	pop	rax
	mov	[x], rax

	; Pop new top num and store in y (should be 4)
	pop	rax
	mov	[y], rax

	; Pop new top num and store in z (should be 2)
	pop	rax
	mov	[z], rax

	; Print x
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, x_str
	mov	rdx, 3
	syscall
	mov	r13, [x]
	add	r13, '0'
	mov	[numchar], r13
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, numchar
	mov	rdx, 1
	syscall
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, nl
	mov	rdx, 1
	syscall

	; Print y
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, y_str
	mov	rdx, 3
	syscall
	mov	r13, [y]
	add	r13, '0'
	mov	[numchar], r13
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, numchar
	mov	rdx, 1
	syscall
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, nl
	mov	rdx, 1
	syscall

	; Print z
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, z_str
	mov	rdx, 3
	syscall
	mov	r13, [z]
	add	r13, '0'
	mov	[numchar], r13
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, numchar
	mov	rdx, 1
	syscall
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, nl
	mov	rdx, 1
	syscall

	; Exit
	mov	rax, 60
	mov	rdi, 0
	syscall
