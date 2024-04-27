animations:
	pusha
	mov al, [cs:.count]
	inc al
	cmp al, 6
	jne .skip
	mov cx, 9
	mov bp, player
	mov ax, [cs:keyboard.coord_move]
	add [cs:player.coord], ax
	mov ax, [cs:keyboard.coord_move+2]
	add [cs:player.coord+2], ax
.anim_lp:
	mov di, [cs:bp]
	cmp di, -1
	je .skip_lp
	inc di
	shl di, 1
	mov ax, [cs:bp+8+di]
	test ax, ax
	jnz .next_elem
	mov di, ax ; 0
.next_elem:
	shr di, 1
	mov [cs:bp], di
.skip_lp:
	add bp, player_struct_size
	loop .anim_lp
	call refresh_screen
	mov al, 0
.skip:
	mov byte[cs:.count], al
	popa
	ret
.count:
	db 0
