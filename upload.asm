mov dh, 1
mov cx, 1
mov ax, 0x0212
push 0x280
pop es
xor bx, bx
pusha
int 13h
popa
mov bx, cx
mov cx, 22

upload_lp:
	push cx
	mov cx, bx
	cmp al, 0x12
	jne .upread
.end_upread:
	add ch, dh
	xor dh, 1
	mov bx, es
	add bx, 0x240
	push bx
	and bx, 0xfff
	sub bx, 0x1000
	neg bx
	cmp bx, 0x240
	jae .cont
	shr bx, 5
	mov al, bl
.cont:
	pop bx
	mov es, bx
	xor bx, bx
	pusha
	int 13h
	popa
	jc load_err
	mov bx, cx
	pop cx
	loop upload_lp
	
	push 0xA000
	pop es
	jmp end_err

.upread:
	push es
	push ax
	mov bx, es
	mov ah, 0
	shl ax, 5
	add bx, ax
	mov es, bx
	pop ax
	xor bx, bx
	sub al, 0x12
	neg al
	pusha
	int 13h
	popa
	jc load_err
	mov ax, 0x0112
	pop es
	jmp .end_upread

load_err:
	push ax
	xor ax, ax
	int 10h
	push 0xb800
	pop es
	pop ax
	mov cx, 4
lp_err:
	push ax
	and ax, 15
	cmp al, 10
	jb .ok
	add al, 7
.ok:
	add al, '0'
	mov di, cx
	shl di, 1
	mov [es:di], al
	pop ax
	shr ax, 4
	loop lp_err
	jmp $

end_err:
