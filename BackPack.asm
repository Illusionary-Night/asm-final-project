INCLUDE Irvine32.inc
INCLUDE display.inc
INCLUDE graph.inc
INCLUDE GameDataType.inc
INCLUDE ToolDataType.inc
INCLUDE BackPack.inc

.data?
    DefaultBackPackWidth    WORD 10
    DefaultBackPackHeight   WORD 10

    CellWidth   WORD 8
    CellHeight  WORD 4

    BackPackFrameColor WORD 07h

    BackPackFrameElement BYTE "*"

    ;ToolsInBackPack TOOL <>

.code
InitBackPack PROC USES esi edi eax ecx,
    PtrBackPack : PTR BACKPACK,
    basePos : COORD

    mov esi , PtrBackPack
    mov ax, DefaultBackPackWidth
    mov (BACKPACK PTR [esi]).BackPackWidth, ax
    mov ax, DefaultBackPackHeight
    mov (BACKPACK PTR [esi]).BackPackHeight, ax

    mov eax, basePos
    mov (BACKPACK PTR [esi]).BasePosition, eax

    lea edi, (BACKPACK PTR [esi]).SlotMap
    mov ecx, 100
    mov al, 0
    rep stosb

    ;mov eax, OFFSET ToolsInBackPack
    ;mov (BACKPACK PTR [esi]).ToolsPtr, eax

    ret
InitBackPack ENDP

ShowBackPack PROC USES esi ecx edx ebx edi,
    PtrBackPack : PTR BACKPACK

    LOCAL tempPos: COORD
    LOCAL realPos: COORD
    LOCAL rect : RECTANGLE
    
    mov esi , PtrBackPack
    ;movzx ecx , (BACKPACK PTR [esi]).BackPackHeight
    ;mov edx , 0

    ;outerLoop:
        ;push ecx
        ;movzx ecx , (BACKPACK PTR [esi]).BackPackWidth
        ;mov ebx , 0

        ;innerLoop:
            ;mov (COORD PTR [tempPos]).X, bx
            ;mov (COORD PTR [tempPos]).Y, dx

            ;INVOKE BpPositiontoRPosition, tempPos

            ;mov (COORD PTR [realPos]).X, ax
            ;mov (COORD PTR [realPos]).Y, dx

            ;lea edi, rect
            ;INVOKE SetRectangle, edi, BackPackFrameElement, BackPackFrameColor , CellWidth, CellHeight, realPos
            ;INVOKE ShowRectangle, edi

            ;add bx , 1
        ;loop innerLoop

        ;pop ecx
        ;add dx , 1
    ;loop outerLoop


    xor bx, bx
    xor dx, dx

    ;mov (COORD PTR tempPos).X, bx
    ;mov (COORD PTR tempPos).Y, dx

    ;INVOKE BpPositiontoRPosition, tempPos

    mov (COORD PTR realPos).X, 0
    mov (COORD PTR realPos).Y, 0

    lea edi, rect
    INVOKE SetRectangle, edi, BackPackFrameElement, BackPackFrameColor, CellWidth, CellHeight, realPos
    INVOKE ShowRectangle, edi
       

    ret
ShowBackPack ENDP

;EraseBackPack PROC USES esi ecx eax,
    ;PtrBackPack : PTR BACKPACK
    
    ;mov esi , PtrBackPack
    ;mov ecx , (BACKPACK PTR [esi]).ToolCount
    ;cmp ecx , 0
    ;jz nothingToErase

    ;lea eax, ToolsInBackPack

    ;eraseLoop:
        ;INVOKE EraseToolSlotPic , eax
        ;INVOKE EraseToolSlotFrame , eax
        ;add eax , SIZEOF TOOL
    ;Loop eraseLoop

;nothingToErase:
    ;ret
;EraseBackPack ENDP
end