.NOLIST
IFNDEF __BackPack
__BackPack EQU 1

BACKPACKWIDTH EQU 8         ; Grid width (8 slots)
BACKPACKHEIGHT EQU 8        ; Grid height (8 slots)
MAXSLOTS EQU BACKPACKWIDTH * BACKPACKHEIGHT

PackGraphPositionX EQU 80       ; X position for status graphs
PackGraphPositionY EQU 30       ; Y position for status graphs

PackFailGraphWidth EQU 88
PackSuccessGraphWidth EQU 88

PackNotSuccessColor EQU 12      ; Red color
PackSuccessColor EQU 10         ; Green color

; --- Macros ---
; Sets the cursor position for drawing graphs
SetPackGraphCursor macro NEWX , NEWY
    push eax

    mov ax , NEWX
    mov PackGraphCursorBuf.X , ax

    mov ax , NEWY
    mov PackGraphCursorBuf.Y , ax

    pop eax
endm

; Advances the cursor Y position (new line)
AddPackGraphCursorY macro num
    push eax

    mov ax , PackGraphCursorBuf.Y
    add ax , num
    mov PackGraphCursorBuf.Y , ax

    pop eax
endm

; --- Data Structure ---
BACKPACK STRUCT
    BackPackWidth       WORD    BACKPACKWIDTH
    BackPackHeight      WORD    BACKPACKHEIGHT
    SlotMap             BYTE    MAXSLOTS DUP(?)          ;0為空 1為滿
    ItemUUIDMap         DWORD   MAXSLOTS DUP(?)
BACKPACK ENDS

; --- Prototypes ---
InitBackPack PROTO , Object : PTR BACKPACK
ShowBackpack PROTO , BackPackBasPos : COORD

ScreenPosToSlotIndex PROTO , ScreenPos : COORD

; Slot management
RecordInBackPack PROTO , Object : PTR BACKPACK , ToolPos : COORD
DelRecordBackPack PROTO , Object : PTR BACKPACK , ToolPos : COORD
CheckBackPackRecord PROTO , Object : PTR BACKPACK , ToolPos : COORD

; Collision Logic
CheckToolInBackPack PROTO , Object : PTR Tool , CompareObject : PTR BACKPACK , CursorPosX : WORD , CursorPosY : WORD
PlaceToolInPackSlotMap PROTO , Object : PTR Tool , PackRecord : PTR BACKPACK , CursorPosX : WORD , CursorPosY : WORD
PlaceToolInPackToolList PROTO , Object : PTR Tool

; UI Display
ShowPackSuccessGraph PROTO
ShowPackNotSuccessGraph PROTO
ShowPackEraseGraph PROTO

ShowPackGraph PROTO , Source : PTR TEXT , _Length : WORD

ErasePackGraph PROTO

ShowSuccessPackGraph PROTO , Source : PTR TEXT , _Length : WORD
GetToolListPtrInBackPack PROTO

ENDIF