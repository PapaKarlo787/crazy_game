org 100h
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
