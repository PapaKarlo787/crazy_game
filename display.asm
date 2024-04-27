refresh_screen:
	
.print_background:
	xor di, di
	mov si, [cs:background]
	mov cx, [cs:background.ds]
	mov ds, cx
	mov cx, 320*200
	rep movsb
	mov cx, 9
	mov bp, player
.lp_print:
	mov ax, [cs:bp]
	cmp ax, -1
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
	push es
	mov ax, [cs:bp + 6] ;ds
	mov ds, ax
	mov si, [cs:bp]
	add si, 4
	mov ax, [cs:bp + 4] ; coord y
	test ax, ax
	jnl .above_zero
	xor ax, ax
.above_zero:
	mov bx, 20
	mul bx
	mov bx, es
	add bx, ax ; coord x
	mov es, bx
	mov ax, [cs:bp + 2]
	mov di, ax
	push bp
	mov bp, [cs:bp]
	mov cx, [ds:bp+2]
	pop bp
.player_lp:
	push cx
	push bp
	mov bp, [cs:bp]
	mov cx, [ds:bp]
	pop bp
	push di
.lp_psl:
	lodsb
	test al, al
	jz .skip_psl
	cmp di, 320
	jae .skip_psl
	test di, di
	jl .skip_psl
	stosb
	loop .lp_psl
	jmp .end_skip_psl
.skip_psl:
	inc di
	loop .lp_psl
.end_skip_psl:
	pop di
	add bx, 20
	mov es, bx
	pop cx
	cmp bx, 0xAFA0
	jae .end_player
	loop .player_lp
.end_player:
	pop es
	ret

animations:
	
	ret
