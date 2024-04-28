org 100h
mov ax, 0x0201
mov cx, 0x0001
mov bx, 0x7c00
xor dx, dx
push 0
pop es
int 13h
push 0
push 0x7c00
retf
