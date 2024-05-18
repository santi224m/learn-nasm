section	.data
	x	dd	10							; Define x as a 4-byte integer intialized to 0

section	.bss					; Reserve space for uninitialized data if necessary

section	.text
	global	main				; Make entry point visible to linker

	extern	printf			; External declaration for printf

	main:								; Setup the stack frame
		push	rbp					; Save base pointer
		mov	rbp, rsp			; Set base pointer to current stack pointer

		; Main function body
		mov 	eax, 4;
		mov	ebx, 5;
		add	eax, ebx;
		mov	 dword [x], eax	; x = 4 + 5
		mov	esi, [x]				; Move x into esi (firt integer argument for printf
	mov	edi, format				; Move address of format string into edi (first argument for printf)
		xor	eax, eax				; Clear eax
		call	printf

		; Return from main
		mov eax, 0				; Return 0 from main
		leave							; Clean up stack frame
		ret								; Return from main to OS

section .data
	format	db	"%d", 10	; Null-terminated format string
