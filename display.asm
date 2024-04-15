refresh_screen:
	
.print_background:
	xor di, di
	mov si, [cs:background]
	mov cx, [cs:background.ds]
	mov ds, cx
	mov cx, 320*200
	rep movsb
	jmp $
	mov cx, 9
	mov bp, player
.lp_print:
	mov ax, [cs:bp]
	test ax, ax
	jz .end_lp_print
	push cx
	call .print_player
	pop cx
.end_lp_print:
	add bp, 8
	loop .lp_print

.end_print:
	ret



.print_player:
	mov ax, [cs:bp+6]
	mov ds, ax
	mov si, [cs:bp]
	mov ax, [cs:bp+4]
	mov bx, 320
	mul bx
	add ax, [cs:bp+2]
	mov di, ax
	mov ch, 0
	mov cl, [cs:bp+7]
.player_lp:
	push cx
	mov cl, [cs:bp+6]
	push di
.player_sub_lp:
	lodsb
	test al, al
	jz .skip_psl
	push ax
	mov ax, 320
	xchg ax, di
	push ax
	xor dx, dx
	div di
	pop di
	pop ax
	cmp dx, 320
	jae .skip_psl
	stosb
	loop .player_sub_lp
.skip_psl:
	inc di
	loop .player_sub_lp
	pop di
	add di, 200
	pop cx
	loop .player_lp
	ret



animations:
	
	ret
