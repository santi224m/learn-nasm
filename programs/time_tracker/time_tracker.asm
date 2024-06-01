; This program takes in work hours for every day
; of the work week and outputs the sum

	section	.data
intro_msg:
	db	'Enter your work hours for every day of the week', 10, 0
mon:	db	'Monday: ', 0
tu:	db	'Tuesday: ', 0
wed:	db	'Wednesday: ', 0
thur:	db	'Thursday: ', 0
fri:	db	'Friday: ', 0
total_msg:
	db	'Total Hours: ', 0

	section	.bss
hours:	resd	5

	section	.text
	global	_start
	extern	print_msg
	extern	get_int
	extern	print_int
	extern	print_nl

_start:
	mov	rbx, 0		; index for hours array

	mov	rdi, intro_msg
	call	print_msg

	mov	rdi, mon
	call	print_msg
	call	get_int
	mov	DWORD [hours+4*rbx], eax
	inc	rbx

	mov	rdi, tu
	call	print_msg
	call	get_int
	mov	DWORD [hours+4*rbx], eax
	inc	rbx

	mov	rdi, wed
	call	print_msg
	call	get_int
	mov	DWORD [hours+4*rbx], eax
	inc	rbx

	mov	rdi, thur
	call	print_msg
	call	get_int
	mov	DWORD [hours+4*rbx], eax
	inc	rbx

	mov	rdi, fri
	call	print_msg
	call	get_int
	mov	DWORD [hours+4*rbx], eax
	inc	rbx

	mov	rcx, 0
	mov 	r10d, 0	; Sum
addLoop:
	cmp	rcx, 5
	Je	printTotal

	add	r10d, DWORD [hours+4*rcx]

	inc	rcx
	Jmp addLoop

printTotal:
	call	print_nl
	mov	rdi, total_msg
	call	print_msg

	mov	edi, r10d
	call	print_int

exit:
	mov	rax, 60
	mov	rdi, 0
	syscall
