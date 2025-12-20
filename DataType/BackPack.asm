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

    ; Grid Line Properties
    linObj     LINE <>
    linChar    BYTE "*"
    linColor   WORD 07h

    ; Collision Check Temp Variables
    check_shape_counter DWORD ?
    check_slotPos   COORD <?,?>

    ; Backpack Storage
    ToolListInBackPack  TOOL 100 DUP(<>)
    ToolNumber DWORD 0

    ; UI Buffers & ASCII Art
    PackGraphTextBuf  TEXT <>

    PackFailGraph1 Byte " _______  _______  _        _ _________   _______          _________  _________ _       " 
    PackFailGraph2 Byte "(  ____ \(  ___  )( (    /|( )\__   __/  (  ____ )|\     /|\__   __/  \__   __/( (    /|"
    PackFailGraph3 Byte "| (    \/| (   ) ||  \  ( ||/    ) (     | (    )|| )   ( |   ) (        ) (   |  \  ( |"
    PackFailGraph4 Byte "| |      | (___) ||   \ | |      | |     | (____)|| |   | |   | |        | |   |   \ | |"
    PackFailGraph5 Byte "| |      |  ___  || (\ \) |      | |     |  _____)| |   | |   | |        | |   | (\ \) |"
    PackFailGraph6 Byte "| |      | (   ) || | \   |      | |     | (      | |   | |   | |        | |   | | \   |"
    PackFailGraph7 Byte "| (____/\| )   ( || )  \  |      | |     | )      | (___) |   | |     ___) (___| )  \  |"
    PackFailGraph8 Byte "(_______/|/     \||/    )_)      )_(     |/       (_______)   )_(     \_______/|/    )_)"



    PackSuccessGraph1 Byte " _______          _________  _________ _          _______  _______  _______  _          "
    PackSuccessGraph2 Byte "(  ____ )|\     /|\__   __/  \__   __/( (    /|  (  ____ )(  ___  )(  ____ \| \    /\   "
    PackSuccessGraph3 Byte "| (    )|| )   ( |   ) (        ) (   |  \  ( |  | (    )|| (   ) || (    \/|  \  / /   "
    PackSuccessGraph4 Byte "| (____)|| |   | |   | |        | |   |   \ | |  | (____)|| (___) || |      |  (_/ /    "
    PackSuccessGraph5 Byte "|  _____)| |   | |   | |        | |   | (\ \) |  |  _____)|  ___  || |      |   _ (     "
    PackSuccessGraph6 Byte "| (      | |   | |   | |        | |   | | \   |  | (      | (   ) || |      |  ( \ \    "
    PackSuccessGraph7 Byte "| )      | (___) |   | |     ___) (___| )  \  |  | )      | )   ( || (____/\|  /  \ \   "
    PackSuccessGraph8 Byte "|/       (_______)   )_(     \_______/|/    )_)  |/       |/     \|(_______/|_/    \/   "
                                                                                     
    PackGraphCursorBuf COORD <PackGraphPositionX , PackGraphPositionY>                                                                                    

    ToolNumberInBackPack DWORD 0
.code
; ---------------------------------------------------------
; InitBackPack
; Clears the SlotMap and ItemUUIDMap (sets memory to 0).
; ---------------------------------------------------------
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

    lea esi , (BACKPACK PTR [esi]).ItemUUIDMap
    mov ecx , MAXSLOTS
    mov al , 0
    rep stosb

    ret
InitBackPack ENDP

; ---------------------------------------------------------
; ShowBackpack
; Draws the grid lines (horizontal and vertical) on screen.
; ---------------------------------------------------------
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

; ---------------------------------------------------------
; ScreenPosToSlotIndex
; Converts 2D coordinates (X, Y) to 1D Array Index.
; Formula: Index = (Y * 8) + X
; ---------------------------------------------------------
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

; ---------------------------------------------------------
; RecordInBackPack / DelRecordBackPack
; Marks a specific slot as occupied (1) or empty (0).
; ---------------------------------------------------------
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

; ---------------------------------------------------------
; CheckBackPackRecord
; Returns 1 if slot is occupied, 0 if empty.
; ---------------------------------------------------------
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

; ---------------------------------------------------------
; CheckToolInBackPack
; Core Logic: Checks if a 4x4 tool fits at cursor position.
; Returns: EAX=1 (Fits), EAX=0 (Collision/Out of Bounds)
; ---------------------------------------------------------
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
            lea edi , (TOOL PTR [esi]).SHAPE
            add edi , check_shape_counter

            cmp check_slotPos.X , 7
            ja SlotFull

            cmp check_slotPos.Y , 7
            ja SlotFull

            mov ax , check_slotPos.Y
            mov bx , 8
            mul bx
            movzx ebx , ax
            movzx eax , check_slotPos.X
            add ebx , eax

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
        mov eax , 0
    Done:
    ret

CheckToolInBackPack ENDP

; ---------------------------------------------------------
; PlaceToolInPackSlotMap
; Writes the tool's shape ('1's) into the Backpack SlotMap.
; ---------------------------------------------------------
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

    ret
PlaceToolInPackSlotMap ENDP

; ---------------------------------------------------------
; PlaceToolInPackToolList
; Clones the tool data into the backpack's internal array.
; ---------------------------------------------------------
PlaceToolInPackToolList PROC USES esi edi eax Object : PTR Tool

    mov esi , Object

    mov edi , OFFSET ToolListInBackPack
    mov eax , SIZEOF TOOL
    mul ToolNumberInBackPack
    add edi , eax

    INVOKE MemClone, edi , esi , SIZEOF TOOL
    inc ToolNumberInBackPack

    ; Debug test: print number of tools in backpack------------------------------
    push edx
	mov dh, 50       ; Y �y�С]0 �q�W�}�l�^
	mov dl, 120       ; X �y�С]0 �q���}�l�^
	call Gotoxy       ; �]�w��r��Ц�m
	pop edx

	push eax
	mov eax, ToolNumberInBackPack
	call WriteInt
    pop eax
    ;--------------------------------------------------------------------------
	

ret
PlaceToolInPackToolList ENDP

; ---------------------------------------------------------
; Graphics Functions (ASCII Art)
; Functions to render Success/Fail banners line by line.
; ---------------------------------------------------------
ShowPackSuccessGraph PROC USES ecx
    INVOKE ShowSuccessPackGraph , OFFSET PackSuccessGraph1 , PackSuccessGraphWidth
ret
ShowPackSuccessGraph ENDP

ShowPackNotSuccessGraph PROC USES ecx
    INVOKE ShowPackGraph , OFFSET PackFailGraph1 , PackFailGraphWidth
ret
ShowPackNotSuccessGraph ENDP

ShowPackEraseGraph PROC USES ecx
    INVOKE ErasePackGraph
ret
ShowPackEraseGraph ENDP

; Helper: Renders 8 lines of text for graphs
ShowPackGraph PROC USES esi eax Source : PTR TEXT , _Length : WORD

    mov esi , Source
    mov eax , 0
    SetPackGraphCursor PackGraphPositionX , PackGraphPositionY
    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackNotSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackNotSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackNotSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackNotSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackNotSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackNotSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackNotSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackNotSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf

    ret
ShowPackGraph ENDP

ErasePackGraph PROC

    SetPackGraphCursor PackGraphPositionX , PackGraphPositionY
    INVOKE SetText , OFFSET PackGraphTextBuf , OFFSET PackSuccessGraph1 , PackNotSuccessColor , PackGraphCursorBuf , PackSuccessGraphWidth
    INVOKE EraseText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1

    INVOKE SetText , OFFSET PackGraphTextBuf , OFFSET PackSuccessGraph2 , PackNotSuccessColor , PackGraphCursorBuf , PackSuccessGraphWidth
    INVOKE EraseText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1

    INVOKE SetText , OFFSET PackGraphTextBuf , OFFSET PackSuccessGraph3 , PackNotSuccessColor , PackGraphCursorBuf , PackSuccessGraphWidth
    INVOKE EraseText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1

    INVOKE SetText , OFFSET PackGraphTextBuf , OFFSET PackSuccessGraph4 , PackNotSuccessColor , PackGraphCursorBuf , PackSuccessGraphWidth
    INVOKE EraseText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1

    INVOKE SetText , OFFSET PackGraphTextBuf , OFFSET PackSuccessGraph5 , PackNotSuccessColor , PackGraphCursorBuf , PackSuccessGraphWidth
    INVOKE EraseText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1

    INVOKE SetText , OFFSET PackGraphTextBuf , OFFSET PackSuccessGraph6 , PackNotSuccessColor , PackGraphCursorBuf , PackSuccessGraphWidth
    INVOKE EraseText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1

    INVOKE SetText , OFFSET PackGraphTextBuf , OFFSET PackSuccessGraph7 , PackNotSuccessColor , PackGraphCursorBuf , PackSuccessGraphWidth
    INVOKE EraseText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1

    INVOKE SetText , OFFSET PackGraphTextBuf , OFFSET PackSuccessGraph8 , PackNotSuccessColor , PackGraphCursorBuf , PackSuccessGraphWidth
    INVOKE EraseText , OFFSET PackGraphTextBuf
    
    ret
ErasePackGraph ENDP

ShowSuccessPackGraph PROC USES esi eax Source : PTR TEXT , _Length : WORD

    mov esi , Source
    mov eax , 0
    SetPackGraphCursor PackGraphPositionX , PackGraphPositionY
    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf
    AddPackGraphCursorY 1
    movzx eax , _Length
    add esi , eax

    INVOKE SetText , OFFSET PackGraphTextBuf , esi , PackSuccessColor , PackGraphCursorBuf , _Length
    INVOKE ShowText , OFFSET PackGraphTextBuf

    ret
ShowSuccessPackGraph ENDP

;return toolList in ebx and return number of tools in edx, both are pointers
; ---------------------------------------------------------
; GetToolListPtrInBackPack
; Returns: EBX = Pointer to Tool List, EDX = Count
; ---------------------------------------------------------
GetToolListPtrInBackPack PROC ;here use ebx and edx to return values

    ; �^�� ToolListInBackPack �}�Y��}
    mov ebx, OFFSET ToolListInBackPack

    ; �^�ǹD��ƶq
    mov edx, ToolNumberInBackPack

    ret
GetToolListPtrInBackPack ENDP

END