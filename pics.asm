org 0
startup_ds = 0x1040
palete:
file "palete.pal"

background_pic:
file "res/class3.pmb":4

times 65536-$ db 0
org 0
start_menu:
	file "res/fonFinal.pmb":4

times 65536-$ db 0
org 0

include "pics_inc/player_pics.asm"
include "pics_inc/enemy_pics.asm"
include "pics_inc/indicators_pics.asm"


times 65536-$ db 0
org 0
db 0

include "pics_inc/other.asm"

loading:
	dw 1709, 8584, 6818, 5736, 1435, 8584, 6818, 4307, 1612, 0, 1612, 7648, 9108, 1709, 11472, 1918, 12829, 1709, 0, 1709, 8584, 1435, 5736, 1075, 10198, 9108, 1075, 1280, 2875, 1139, 3836, 4554, 5736, 7648, 9108
	db 4, 4, 4, 4, 4, 4, 4, 4, 8, 1, 8, 4, 4, 4, 4, 8, 4, 12, 1, 12, 4, 8, 4, 4, 4, 4, 8, 8, 4, 4, 4, 4, 4, 4, 4
