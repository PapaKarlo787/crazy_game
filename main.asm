org 0
use16
include "upload.asm"
mov ax, 13h
int 10h

push startup_ds
pop ds
mov dx, 0x3c8
mov al, 0
out dx, al

mov si, palete
mov cx, 768
inc dx
rep outsb

mov word [cs:background], start_menu
mov word [cs:background.ds], startup_ds+0x1000
call refresh_screen
mov ax, 0
int 16h

call setup_handlers
mov word [cs:background], background_pic
mov word [cs:background.ds], startup_ds

mov word [cs:player.data+8], player_standing_1
mov word [cs:player.data+10], player_standing_2
mov word [cs:player.data+12], player_standing_3
mov word [cs:player.data+14], 0
mov word [cs:player.data], 0
mov word [cs:player.ds], startup_ds + 0x2000
mov word [cs:player.coord], 30
mov word [cs:player.coord+2], 35

mov word [cs:npc1.data], 0
mov word [cs:npc1.ds], startup_ds + 0x2000
mov word [cs:npc1.coord], 30
mov word [cs:npc1.coord+2], 35
mov word [cs:npc1.data+8], enemy_standing_1
mov word [cs:npc1.data+10], enemy_standing_2
mov word [cs:npc1.data+12], enemy_standing_3
mov word [cs:npc1.data+14], 0

mov bx, 301
mov ax, lion
mov cx, startup_ds + 0x2000
call play_mus



jmp $

;todo
; реализовать обработку анимаций неигроковых спрайтов
; 

include "animations.asm"
include "handlers.asm"
include "display.asm"
include "music.asm"
include "structures.asm"
times 65536-512-$ db 0
include "pics.asm"
times 1440*1024-$-65536*4 db 0
