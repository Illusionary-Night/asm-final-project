INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/display.inc
INCLUDE ./asm-final-project/IO/graph.inc

.data

    CELL_WIDTH  WORD 8
    CELL_HEIGHT WORD 8

    StartPos    COORD <0, 0>      

    linObj     LINE <>
    linChar    BYTE "*"
    linColor   WORD 07h           

.code

DrawBackpack PROC USES ecx eax ebx BackPackBasPos : COORD

    mov ax , BackPackBasPos.X
    mov StartPos.X , ax
    mov ax , BackPackBasPos.Y
    mov StartPos.Y , ax

    mov ecx , 8
    mov bx , StartPos.Y
    Hloop:
        mov ax , StartPos.X
        mov linObj.Position.X , ax
        mov linObj.Position.Y , bx

        INVOKE SetLine, OFFSET linObj, linChar, linColor, 0, 70, linObj.Position
        INVOKE ShowLine, OFFSET linObj

        add bx , 7
    Loop Hloop

    mov ecx , 11
    mov bx , StartPos.X
    Wloop:
        mov ax , StartPos.Y
        mov linObj.Position.X , bx
        mov linObj.Position.Y , ax

        INVOKE SetLine, OFFSET linObj, linChar, linColor, 1, 49, linObj.Position
        INVOKE ShowLine, OFFSET linObj

        add bx , 7
    Loop Wloop

    ret
DrawBackpack ENDP

END