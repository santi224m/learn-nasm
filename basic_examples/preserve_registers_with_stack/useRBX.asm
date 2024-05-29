; Store rbx register on stack during function prologue,
; use rbx register with other values
; restore rbx register during function epilogue

	section	.text
	global	useRBX

useRBX:
	; function prologue
	push	rbp			; Store base pointer
	mov	rbp, rsp		; Move stack pointer to base pointer
	sub	rsp, 0x10		; Allocate 32 bits (4 bytes) on stack
	mov	[rsp-0x10], rbx		; Store rbx value

	; Change rbx values
	mov	rbx, 20
	mov	rbx, 30

	; function epilogue
	mov	rbx, [rsp-0x10]		; Restore rbx value
	add	rsp, 0x10		; Deallocate 32 bits (4 bytes) from stack
	pop	rbp			; Restore base pointer
	ret
