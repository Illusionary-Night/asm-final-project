INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/display.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/DataType/BackPack.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/MemOperation.inc

.data

    CELL_WIDTH  WORD 7
    CELL_HEIGHT WORD 7

    StartPos    COORD <0, 0>      

    linObj     LINE <>
    linChar    BYTE "*"
    linColor   WORD 07h

    check_shape_counter DWORD ?
    check_slotPos   COORD <?,?>

    ToolListInBackPack  TOOL 100 DUP(<>)
    ToolNumber DWORD 1
.code

InitBackPack PROC USES esi edi ecx eax ebx,
    Object : PTR BACKPACK

    mov esi , Object
    mov ax , BACKPACKWIDTH
    mov (BACKPACK PTR [esi]).BackPackWidth , ax
    mov ax , BACKPACKHEIGHT
    mov (BACKPACK PTR [esi]).BackPackHeight , ax

    lea edi , (BACKPACK PTR [esi]).SlotMap
    mov ecx , MAXSLOTS
    mov al , 0
    rep stosb

    mov ecx , 64
    mov ebx , 0
    mov eax , 0
    L:
        mov al , (BACKPACK PTR [esi]).SlotMap[ebx]
        call WriteInt
        inc ebx
    loop L


    lea esi , (BACKPACK PTR [esi]).ItemUUIDMap
    mov ecx , MAXSLOTS
    mov al , 0
    rep stosb

    ret
InitBackPack ENDP

ShowBackpack PROC USES ecx eax ebx edx BackPackBasPos : COORD

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

        mov ax , CELL_HEIGHT
        mov dx , BACKPACKHEIGHT
        mul dx

        INVOKE SetLine, OFFSET linObj, linChar, linColor, 0, ax, linObj.Position
        INVOKE ShowLine, OFFSET linObj

        add bx , 7
    Loop Hloop

    mov ecx , 9
    mov bx , StartPos.X
    Wloop:
        mov ax , StartPos.Y
        mov linObj.Position.X , bx
        mov linObj.Position.Y , ax

        mov ax , CELL_WIDTH
        mov dx , BACKPACKWIDTH
        mul dx

        INVOKE SetLine, OFFSET linObj, linChar, linColor, 1, ax, linObj.Position
        INVOKE ShowLine, OFFSET linObj

        add bx , 7
    Loop Wloop

    ret
ShowBackpack ENDP

ScreenPosToSlotIndex PROC USES ebx ecx , ScreenPos : COORD

    mov ax , ScreenPos.Y
    mov bx , 8
    mul bx
    mov cx , ax

    mov ax , ScreenPos.X
    add cx , ax

    movzx eax , cx

    ret
ScreenPosToSlotIndex ENDP
    
RecordInBackPack PROC USES eax ebx esi edi ecx edx Object : PTR BACKPACK , ToolPos : COORD      ;record 1 if tool is in

    mov esi , Object

    INVOKE ScreenPosToSlotIndex , ToolPos

    mov ebx , eax
    mov (BACKPACK PTR [esi]).SlotMap[ebx] , 1

    ret
RecordInBackPack ENDP

DelRecordBackPack PROC USES eax ebx edx esi edi ecx Object : PTR BACKPACK , ToolPos : COORD     ;change back to zero if take out the tool

    mov esi , Object

    INVOKE ScreenPosToSlotIndex , ToolPos

    mov ebx , eax
    mov (BACKPACK PTR [esi]).SlotMap[ebx] , 0

    ret
DelRecordBackPack ENDP

CheckBackPackRecord PROC USES esi ebx ecx edx Object : PTR BACKPACK , ToolPos : COORD        ;this function will return 1 or 0 in eax

    mov esi , Object

    INVOKE ScreenPosToSlotIndex , ToolPos

    mov ebx , eax

    cmp (BACKPACK PTR [esi]).SlotMap[ebx] , 0
    je isNull
    mov eax , 1
    jmp done

    isNull:
    mov eax , 0

    done:
    ret

CheckBackPackRecord ENDP


CheckToolInBackPack PROC USES esi edi ecx ebx edx Object : PTR Tool , CompareObject : PTR BACKPACK , CursorPosX : WORD , CursorPosY : WORD

    LOCAL startX : WORD

    mov esi , Object
    mov edx , CompareObject
    mov ecx , 4
    mov check_shape_counter , 0

    mov ax , CursorPosX
    mov check_slotPos.X , ax
    mov startX , ax
    mov ax , CursorPosY
    mov check_slotPos.Y , ax

    
    OuterLoop:
        push ecx
        mov ecx , 4

        mov ax , startX
        mov check_slotPos.X , ax

        InnerLoop:
            cmp check_slotPos.X , 7
            ja Next

            cmp check_slotPos.Y , 7
            ja Next

            mov ax , check_slotPos.Y
            mov bx , 8
            mul bx
            movzx ebx , ax
            movzx eax , check_slotPos.X
            add ebx , eax

            lea edi , (TOOL PTR [esi]).SHAPE
            add edi , check_shape_counter

            cmp (BACKPACK PTR [edx]).SlotMap[ebx] , 1
            je SlotFull
            jmp Next

            SlotFull:
                cmp BYTE PTR [edi] , '1'
                je ToolCannotPitIn
                jmp Next
                
        Next:
        add check_slotPos.X , 1
        add check_shape_counter , SIZEOF BYTE
        Loop InnerLoop

        pop ecx
        add check_slotPos.Y , 1
    Loop OuterLoop

    mov eax , 1
    jmp Done

    ToolCannotPitIn:
        mov eax , 8
        call WriteInt

    Done:
    ret

CheckToolInBackPack ENDP

PlaceToolInPackSlotMap PROC USES esi edi ecx eax edx ebx Object : PTR Tool , PackRecord : PTR BACKPACK , CursorPosX : WORD , CursorPosY : WORD

    LOCAL startX : WORD

    mov esi , Object
    mov edx , PackRecord

    mov ecx , 4
    mov check_shape_counter , 0

    mov ax , CursorPosX
    mov check_slotPos.X , ax
    mov startX , ax
    mov ax , CursorPosY
    mov check_slotPos.Y , ax

    OuterLoop:
        push ecx
        mov ecx , 4

        mov ax , startX
        mov check_slotPos.X , ax

        InnerLoop:
            cmp check_slotPos.X , 7
            ja Next

            cmp check_slotPos.Y , 7
            ja Next

            mov ax , check_slotPos.Y
            mov bx , 8
            mul bx
            movzx ebx , ax
            movzx eax , check_slotPos.X
            add ebx , eax

            lea edi , (TOOL PTR [esi]).SHAPE
            add edi , check_shape_counter

            cmp BYTE PTR [edi] , '1'
            jne Next
            mov (BACKPACK PTR [edx]).SlotMap[ebx] , 1
                
        Next:
        add check_slotPos.X , 1
        add check_shape_counter , SIZEOF BYTE
        Loop InnerLoop

        pop ecx
        add check_slotPos.Y , 1
    Loop OuterLoop

    mov ecx , 64
    mov ebx , 0
    mov eax , 0
    L1:
        mov al , (BACKPACK PTR [edx]).SlotMap[ebx]
        call WriteInt
        inc ebx
    loop L1

    ret
PlaceToolInPackSlotMap ENDP

PlaceToolInPackToolList PROC USES esi edi eax Object : PTR Tool

    mov esi , Object

    mov edi , OFFSET ToolListInBackPack
    mov eax , SIZEOF TOOL
    mul ToolNumber
    add edi , eax

    INVOKE MemClone, edi , esi , SIZEOF TOOL
    inc ToolNumber

ret
PlaceToolInPackToolList ENDP

END