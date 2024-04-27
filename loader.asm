org 0x7c00
mov bx, 0xd55
mov al, 0xb6
	out 0x43, al

	mov al, bl
	out 0x42, al
	mov al, bh
	out 0x42, al

	in al, 0x61
	or al, 3
	out 0x61, al
	jmp $

mov dh, 0
mov cx, 2
mov ax, 0x0211
push 0x60
pop es
xor bx, bx
int 13h

push 0xA000
pop es
push 0x9000
pop ss
xor sp, sp
push 0x60
push 0
retf

times 510-($-$$) db 0
dw 0xaa55

include "main.asm"
