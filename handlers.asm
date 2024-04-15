setup_handlers:
	push 0
	pop fs
	mov ax, [fs:34]
	mov [cs:timer.old + 2], ax
	mov ax, [fs:32]
	mov [cs:timer.old], ax
	mov ax, [fs:38]
	mov [cs:keyboard.old + 2], ax
	mov ax, [fs:36]
	mov [cs:keyboard.old], ax
	cli
	mov [fs:34], cs
	mov [fs:38], cs
	mov word [fs:32], timer
	mov word [fs:36], keyboard
	sti
	ret
	


keyboard:
	
	
	jmp far[cs:keyboard.old]
	
.old:
	dw 0, 0

timer:
	;call mus_handler
	;call animations
	
	jmp far[cs:timer.old]
	
.old:
	dw 0, 0

