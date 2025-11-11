INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/IO/StartScene.inc

setCoord MACRO deltax, deltay
push x
push y
add x, deltax
add y, deltay
mov ax, x
mov bx, y
mov position.X, ax
mov position.Y, bx
pop y
pop x
ENDM

.data
name1 BYTE "$$$$$$$\                     $$\       ",
            "$$  __$$\                    $$ |      ",
            "$$ |  $$ |$$$$$$\   $$$$$$$\ $$ |  $$\ ",
            "$$$$$$$  |\____$$\ $$  _____|$$ | $$  |", 0

name2 BYTE "$$  ____/ $$$$$$$ |$$ /      $$$$$$  / ",
            "$$ |     $$  __$$ |$$ |      $$  _$$<  ",
            "$$ |     \$$$$$$$ |\$$$$$$$\ $$ | \$$\ ",
            "\__|      \_______| \_______|\__|  \__|", 0

name3 BYTE "$$$$$$\ $$\     ",
            "\_$$  _|$$ |    ",
            "  $$ |$$$$$$\   ",
            "  $$ |\_$$  _|  ",
            "  $$ |  $$ |    ",
            "  $$ |  $$ |$$\ ",
            "$$$$$$\ \$$$$  |",
            "\______| \____/ ", 0

name4 BYTE "$$\   $$\           ",
            "$$ |  $$ |          ",
            "$$ |  $$ | $$$$$$\  ",
            "$$ |  $$ |$$  __$$\ ",
            "$$ |  $$ |$$ /  $$ |", 0

name5 BYTE "$$ |  $$ |$$ |  $$ |",
            "\$$$$$$  |$$$$$$$  |",
            " \______/ $$  ____/ ",
            "          $$ |      ",
            "          $$ |      ",
            "          \__|      ", 0

name6 BYTE "$$\ ",
            "$$ |",
            "$$ |",
            "$$ |",
            "\__|",
            "    ",
            "$$\ ",
            " \__|", 0

name7 BYTE  " _____                                                _                _              _             _   ", 0
name8 BYTE  "|  __ \                                              | |              | |            | |           | |  ", 0
name9 BYTE  "| |__) | __ ___  ___ ___   ___ _ __   __ _  ___ ___  | | _____ _   _  | |_ ___    ___| |_ __ _ _ __| |_ ", 0
name10 BYTE "|  ___/ '__/ _ \/ __/ __| / __| '_ \ / _` |/ __/ _ \ | |/ / _ \ | | | | __/ _ \  / __| __/ _` | '__| __|", 0
name11 BYTE "| |   | | |  __/\__ \__ \ \__ \ |_) | (_| | (_|  __/ |   <  __/ |_| | | || (_) | \__ \ || (_| | |  | |_ ", 0
name12 BYTE "|_|   |_|  \___||___/___/ |___/ .__/ \__,_|\___\___| |_|\_\___|\__, |  \__\___/  |___/\__\__,_|_|   \__|", 0
name13 BYTE "                              | |                               __/ |                                   ", 0
name14 BYTE "                              |_|                              |___/                                    ", 0
x WORD 15   ;if you want to move the position of "pack it up!" text, just change x and y
y WORD 2

.code
ShowTitle proc uses ax bx position: COORD, start_pic: PTR PICTURE

setCoord 0, 0
INVOKE Setpicture, start_pic, OFFSET name1, 4, 39, 4, position
INVOKE Showpicture, start_pic

setCoord 0, 4
INVOKE Setpicture, start_pic, OFFSET name2, 4, 39, 4, position
INVOKE Showpicture, start_pic

setCoord 45, 0
INVOKE Setpicture, start_pic, OFFSET name3, 9, 16, 8, position
INVOKE Showpicture, start_pic

setCoord 67, 0
INVOKE Setpicture, start_pic, OFFSET name4, 10, 20, 5, position
INVOKE Showpicture, start_pic

setCoord 67, 5
INVOKE Setpicture, start_pic, OFFSET name5, 10, 20, 6, position
INVOKE Showpicture, start_pic

setCoord 87, 0
INVOKE Setpicture, start_pic, OFFSET name6, 7, 4, 8, position
INVOKE Showpicture, start_pic

mov x, 8;if you want to move the position of "press any key to start" text, just change these 5 line code
mov y, 20

setCoord 0, 0
INVOKE SetPicture, start_pic, OFFSET name7, 7, 104, 1, position
INVOKE Showpicture, start_pic

setCoord 0, 1
INVOKE Setpicture, start_pic, OFFSET name8, 7, 104, 1, position
INVOKE Showpicture, start_pic

setCoord 0, 2
INVOKE Setpicture, start_pic, OFFSET name9, 7, 104, 1, position
INVOKE Showpicture, start_pic

setCoord 0, 3
INVOKE Setpicture, start_pic, OFFSET name10, 7, 104, 1, position
INVOKE Showpicture, start_pic

setCoord 0, 4
INVOKE Setpicture, start_pic, OFFSET name11, 7, 104, 1, position
INVOKE Showpicture, start_pic

setCoord 0, 5
INVOKE Setpicture, start_pic, OFFSET name12, 7, 104, 1, position
INVOKE Showpicture, start_pic

setCoord 0, 6
INVOKE Setpicture, start_pic, OFFSET name13, 7, 104, 1, position
INVOKE Showpicture, start_pic

setCoord 0, 7
INVOKE Setpicture, start_pic, OFFSET name14, 7, 104, 1, position
INVOKE Showpicture, start_pic
ret 8
ShowTitle endp

end