animations:
	pusha
	mov al, [cs:.count]
	inc al
	cmp al, 6
	jne .skip
	mov cx, 9
	mov bp, player
.anim_lp:
	mov di, [cs:bp]
	inc di
	shl di, 1
	mov ax, [cs:bp+8+di]
	test ax, ax
	jnz .next_elem
	mov di, ax ; 0
.next_elem:
	shr di, 1
	mov [cs:bp], di
	call refresh_screen
	mov al, 0
.skip:
	mov byte[cs:.count], al
	popa
	ret
.count:
	db 0
