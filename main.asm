org 0
use16
include "upload.asm"
mov ax, 13h
int 10h

mov dx, 0x3c8
mov al, 0
out dx, al

mov si, palete
mov cx, 768
inc dx
rep outsb

mov word [cs:background], background_pic
mov word [cs:background.ds], startup_ds
mov word [cs:player.data], player_standing_1
mov word [cs:player.ds], startup_ds + 0x1040
mov word [cs:player.coord], -20
mov word [cs:player.coord+2], -10



call refresh_screen
jmp $

;todo
; реализовать обработку анимаций неигроковых спрайтов
; 

include "handlers.asm"
include "display.asm"
include "music.asm"
include "structures.asm"
times 65536-512-$ db 0
include "pics.asm"
times 1440*1024-$-65536*3 db 0
