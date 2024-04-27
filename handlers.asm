setup_handlers:
	push 0
	pop fs
	mov ax, [fs:34]
	mov [cs:timer.old + 2], ax
	mov ax, [fs:32]
	mov [cs:timer.old], ax
	mov ax, [fs:38]
	mov [cs:keyboard.old + 2], ax
	mov ax, [fs:36]
	mov [cs:keyboard.old], ax
	cli
	mov [fs:34], cs
	mov [fs:38], cs
	mov word [fs:32], timer
	mov word [fs:36], keyboard
	sti
	ret
	


keyboard:
	pusha
	in al, 60h
	push ax
	xor al, [cs:.pressed]
	cmp al, 0x80
	pop ax
	je .stop
	cmp byte [cs:.pressed], 0
	jne .ret_kbd
	cmp al, 0x1e
	je .left
	cmp al, 0x20
	je .right
	cmp al, 0x1f
	je .down
	cmp al, 0x11
	je .up
.ret_kbd:
	popa
	jmp far[cs:keyboard.old]
	
	
.left:
	mov word[cs:.coord_move], -8
	mov byte[cs:.pressed], al
	mov word[cs:player+8], player_running_left_1
	mov word[cs:player+10], player_running_left_2
	mov word[cs:player+12], player_running_left_3
	mov word[cs:player+14], 0
	jmp .ret_kbd

.right:
	mov word[cs:.coord_move], 8
	mov byte[cs:.pressed], al
	mov word[cs:player+8], player_running_right_1
	mov word[cs:player+10], player_running_right_2
	mov word[cs:player+12], player_running_right_3
	mov word[cs:player+14], 0
	jmp .ret_kbd
.up:
	mov word[cs:.coord_move+2], -8
	mov byte[cs:.pressed], al
	mov word[cs:player+8], player_running_up_1
	mov word[cs:player+10], player_running_up_2
	mov word[cs:player+12], 0
	jmp .ret_kbd
.down:
	mov word[cs:.coord_move+2], 8
	mov byte[cs:.pressed], al
	mov word[cs:player+8], player_running_down_1
	mov word[cs:player+10], player_running_down_2
	mov word[cs:player+12], 0
	jmp .ret_kbd
.stop:
	mov word[cs:.coord_move], 0
	mov word[cs:.coord_move+2], 0
	mov byte[cs:.pressed], 0
	mov word[cs:player+8], player_standing_1
	mov word[cs:player+10], player_standing_2
	mov word[cs:player+12], player_standing_3
	mov word[cs:player+14], 0
	jmp .ret_kbd

.coord_move:
	dw 0, 0
.pressed:
	db 0
.old:
	dw 0, 0

timer:
	call mus_handler
	call animations
	jmp far[cs:timer.old]
	
.old:
	dw 0, 0

