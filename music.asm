stop:
	mov word [cs:mus_handler.base], 0
	ret

play_mus:
	mov [cs:mus_handler.base], ax
	mov word [cs:mus_handler.pointer], 0
	mov word [cs:mus_handler.size], bx
	mov word [cs:mus_handler.ds], cx
	mov ds, cx
	xchg ax, bx
	mov bp, [ds:bx]	

	add bx, ax
	add bx, ax
	mov al, [ds:bx]
	mov bx, bp
	mov [cs:mus_handler.delay], al

	mov al, 0xb6
	out 0x43, al

	mov al, bl
	out 0x42, al
	mov al, bh
	out 0x42, al

	in al, 0x61
	or al, 3
	out 0x61, al
	ret


mus_handler:
	push ds
	cmp word[cs:mus_handler.base], 0
	je .end_ret
	mov ds, [cs:mus_handler.ds]
	push bx
	mov bl, [cs:mus_handler.delay]
	dec bl
	jnz .end
	mov bx, [cs:mus_handler.pointer]
	inc bx
	cmp bx, [cs:mus_handler.size]
	jne .next
	xor bx, bx
.next:
	mov [cs:mus_handler.pointer], bx
	push bx
	push ax
	mov ax, 3
	xchg ax, bx
	mul bx
	mov bx, ax
	add bx, [cs:mus_handler.base]
	mov bx, [ds:bx] ;freq
	in al, 0x61
	and al, 0xfc
	out 0x61, al
	mov al, 0xb6
	out 0x43, al
	mov al, bl
	out 0x42, al
	mov al, bh
	out 0x42, al
	in al, 0x61
	or al, 3
	out 0x61, al
	pop ax
	pop bx
	add bx, [cs:mus_handler.size]
	add bx, [cs:mus_handler.size]
	add bx, [cs:mus_handler.base]
	mov bl, [ds:bx]
.end:
	mov [cs:mus_handler.delay], bl
	pop bx
.end_ret:
	pop ds
	ret
.delay:
	db 0
.pointer:
	dw 0
.size:
	dw 0
.base:
	dw 0
.ds:
	dw 0
