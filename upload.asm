mov dh, 1
mov cx, 1
mov ax, 0x0200 + 18
push 0x280
pop es
xor bx, bx
pusha
push es
int 13h
pop es
popa
mov bx, cx
mov cx, 50

upload_lp:
	push cx
	mov cx, bx
	cmp al, 18
	jne .upread
.end_upread:
	add ch, dh
	xor dh, 1
	mov bx, es
	add bx, 18*32;512 >> 4

	push bx
	and bx, 0xfff
	sub bx, 0x1000
	neg bx
	cmp bx, 18 * 32;512 >> 4
	jae .cont
	shr bx, 5
	mov al, bl
.cont:
	pop bx

	mov es, bx
	xor bx, bx
	pusha
	push es
	int 13h
	pop es
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
	mov cl, al
	inc cl
	sub al, 18
	neg al
	pusha
	push es
	int 13h
	pop es
	popa
	jc load_err
	mov cl, 1
	mov al, 18
	pop es
	jmp .end_upread

load_err:
	push cx
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
