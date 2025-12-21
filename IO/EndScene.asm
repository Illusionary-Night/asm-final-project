INCLUDE ./asm-final-project/SysInc/Irvine32.inc

INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/IO/EndScene.inc

.data
;------------------------------------------------------
; ASCII art for END GAME screen (8 lines)
;------------------------------------------------------
gameEndStr1 BYTE " $$$$$$\                                           $$$$$$\                                 ", 0
gameEndStr2 BYTE "$$  __$$\                                         $$  __$$\                                ", 0
gameEndStr3 BYTE "$$ /  \__| $$$$$$\  $$$$$$\$$$$\   $$$$$$\        $$ /  $$ |$$\    $$\  $$$$$$\   $$$$$$\  ", 0
gameEndStr4 BYTE "$$ |$$$$\  \____$$\ $$  _$$  _$$\ $$  __$$\       $$ |  $$ |\$$\  $$  |$$  __$$\ $$  __$$\ ", 0
gameEndStr5 BYTE "$$ |\_$$ | $$$$$$$ |$$ / $$ / $$ |$$$$$$$$ |      $$ |  $$ | \$$\$$  / $$$$$$$$ |$$ |  \__|", 0
gameEndStr6 BYTE "$$ |  $$ |$$  __$$ |$$ | $$ | $$ |$$   ____|      $$ |  $$ |  \$$$  /  $$   ____|$$ |      ", 0
gameEndStr7 BYTE "\$$$$$$  |\$$$$$$$ |$$ | $$ | $$ |\$$$$$$$\        $$$$$$  |   \$  /   \$$$$$$$\ $$ |      ", 0
gameEndStr8 BYTE " \______/  \_______|\__| \__| \__| \_______|       \______/     \_/     \_______|\__|      ", 0

;------------------------------------------------------
; Cursor and TEXT buffer for end scene
;------------------------------------------------------
EndSceneCursor COORD <0,0>
EndGameText TEXT <>
                                                                                   
.code
;------------------------------------------------------
; ShowEndGame
; Display END GAME ASCII art line by line
;------------------------------------------------------
ShowEndGame proc uses ecx esi
    SetEndSceneCursor 59, 10
    mov ecx, 8
    mov esi, OFFSET gameEndStr1
L1:
    INVOKE SetText, OFFSET EndGameText, esi, 7, EndSceneCursor, LENGTHOF gameEndStr1
    INVOKE ShowText, OFFSET EndGameText
    add esi, LENGTHOF gameEndStr1
    inc EndSceneCursor.Y
    loop L1

    ret 1
ShowEndGame endp

end