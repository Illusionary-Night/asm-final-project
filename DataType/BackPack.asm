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

ShowBackpack PROC USES ecx eax ebx BackPackBasPos : COORD

    mov ax , BackPackBasPos.X
    mov StartPos.X , ax
    mov ax , BackPackBasPos.Y
    mov StartPos.Y , ax

    mov ecx , 9
    mov bx , StartPos.Y
    Hloop:
        mov ax , StartPos.X
        mov linObj.Position.X , ax
        mov linObj.Position.Y , bx

        INVOKE SetLine, OFFSET linObj, linChar, linColor, 0, 56, linObj.Position
        INVOKE ShowLine, OFFSET linObj

        add bx , 7
    Loop Hloop

    mov ecx , 9
    mov bx , StartPos.X
    Wloop:
        mov ax , StartPos.Y
        mov linObj.Position.X , bx
        mov linObj.Position.Y , ax

        INVOKE SetLine, OFFSET linObj, linChar, linColor, 1, 56, linObj.Position
        INVOKE ShowLine, OFFSET linObj

        add bx , 7
    Loop Wloop

    ret
ShowBackpack ENDP
    
RecordInBackPack PROC USES eax ebx esi edi ecx edx Object : PTR BACKPACK , ToolPos : COORD      ;record 1 if tool is in

    mov esi , Object

    mov ax , ToolPos.Y
    mov cx , 7
    xor dx , dx
    div cx
    mov bx , 10
    mul bx
    mov cx , ax

    mov ax , ToolPos.X 
    mov bx , 7
    xor dx , dx
    div bx
    add cx , ax

    movzx ebx , cx
    mov (BACKPACK PTR [esi]).SlotMap[ebx] , 1

    ret
RecordInBackPack ENDP

DelRecordBackPack PROC USES eax ebx edx esi edi ecx Object : PTR BACKPACK , ToolPos : COORD     ;change back to zero if take out the tool

    mov esi , Object

    mov ax , ToolPos.Y
    mov cx , 7
    xor dx , dx
    div cx
    mov bx , 10
    mul bx
    mov cx , ax

    mov ax , ToolPos.X
    mov bx , 7
    xor dx , dx
    div bx
    add cx , ax

    movzx ebx , cx
    mov (BACKPACK PTR [esi]).SlotMap[ebx] , 0

    ret
DelRecordBackPack ENDP

CheckBackPackRecord PROC USES esi ebx ecx edx Object : PTR BACKPACK , ToolPos : COORD        ;this function will return 1 or 0 in eax

    mov esi , Object

    mov ax , ToolPos.Y
    mov cx , 7
    xor dx , dx
    div cx
    mov bx , 10
    mul bx
    mov cx , ax

    mov ax , ToolPos.X
    mov bx , 7
    xor dx , dx
    div bx
    add cx , ax

    movzx ebx , cx

    cmp (BACKPACK PTR [esi]).SlotMap[ebx] , 0
    je isNull
    mov eax , 1
    jmp done

    isNull:
    mov eax , 0

    done:
    ret

CheckBackPackRecord ENDP

END