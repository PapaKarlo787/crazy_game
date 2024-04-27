org 0
startup_ds = 0x1040
palete:
file "palete.pal"

background_pic:
file "res/maxresdefault.pmb":4

times 65536-$ db 0
org 0

db 0
player_standing_1:
	file "res/1.pmb"

start_menu:

player_standing_2:
	
player_running_left_1:
	file "res/2.pmb"
	
player_running_left_2:
	file "res/3.pmb"

player_running_left_3:
	file "res/4.pmb"

player_running_right_1:

player_running_right_2:
	

times 65536-$ db 0
org 0
