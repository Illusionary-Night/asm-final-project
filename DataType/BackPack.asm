INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/display.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/DataType/BackPack.inc

.data

    CELL_WIDTH  WORD 8
    CELL_HEIGHT WORD 8

    StartPos    COORD <0, 0>      

    linObj     LINE <>
    linChar    BYTE "*"
    linColor   WORD 07h

.code

InitBackPack PROC USES esi edi ecx eax,
    Object : PTR BACKPACK

    mov esi , Object
    mov ax , 10
    mov (BACKPACK PTR [esi]).BackPackWidth , ax
    mov (BACKPACK PTR [esi]).BackPackHeight , ax

    lea edi , (BACKPACK PTR [esi]).SlotMap
    mov ecx , 100
    mov al , 0
    rep stosb
    ret
InitBackPack ENDP

DrawBackpack PROC USES ecx eax ebx BackPackBasPos : COORD

    mov ax , BackPackBasPos.X
    mov StartPos.X , ax
    mov ax , BackPackBasPos.Y
    mov StartPos.Y , ax

    mov ecx , 7
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

        INVOKE SetLine, OFFSET linObj, linChar, linColor, 1, 42, linObj.Position
        INVOKE ShowLine, OFFSET linObj

        add bx , 7
    Loop Wloop

    ret
DrawBackpack ENDP
    
RecordIn PROC USES eax ebx esi edi Object : PTR BACKPACK , ToolPos : COORD      ;record 1 if tool is in

    mov esi , Object

    mov ax , ToolPos.Y
    mov bx , 10
    mul bx
    add ax , ToolPos.X 

    movzx ebx , ax
    mov (BACKPACK PTR [esi]).SlotMap[ebx] , 1

    ret
RecordIn ENDP

DelRecord PROC USES eax ebx esi edi Object : PTR BACKPACK , ToolPos : COORD     ;change back to zero if take out the tool

    mov esi , Object

    mov ax , ToolPos.Y
    mov bx , 10
    mul bx
    add ax , ToolPos.X

    movzx ebx , ax
    mov (BACKPACK PTR [esi]).SlotMap[ebx] , 0

    ret
DelRecord ENDP

END