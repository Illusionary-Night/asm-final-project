.NOLIST
IFNDEF __BackPack
__BackPack EQU 1

BACKPACKWIDTH EQU 8
BACKPACKHEIGHT EQU 8
MAXSLOTS EQU BACKPACKWIDTH * BACKPACKHEIGHT

PackGraphPositionX EQU 80
PackGraphPositionY EQU 30

PackFailGraphWidth EQU 88
PackSuccessGraphWidth EQU 88

PackNotSuccessColor EQU 12
PackSuccessColor EQU 10

SetPackGraphCursor macro NEWX , NEWY
    push eax

    mov ax , NEWX
    mov PackGraphCursorBuf.X , ax

    mov ax , NEWY
    mov PackGraphCursorBuf.Y , ax

    pop eax
endm

AddPackGraphCursorY macro num
    push eax

    mov ax , PackGraphCursorBuf.Y
    add ax , num
    mov PackGraphCursorBuf.Y , ax

    pop eax
endm


BACKPACK STRUCT
    BackPackWidth       WORD    BACKPACKWIDTH
    BackPackHeight      WORD    BACKPACKHEIGHT
    SlotMap             BYTE    MAXSLOTS DUP(?)          ;0為空 1為滿
    ItemUUIDMap         DWORD   MAXSLOTS DUP(?)
BACKPACK ENDS

InitBackPack PROTO , Object : PTR BACKPACK
ShowBackpack PROTO , BackPackBasPos : COORD

ScreenPosToSlotIndex PROTO , ScreenPos : COORD

RecordInBackPack PROTO , Object : PTR BACKPACK , ToolPos : COORD
DelRecordBackPack PROTO , Object : PTR BACKPACK , ToolPos : COORD
CheckBackPackRecord PROTO , Object : PTR BACKPACK , ToolPos : COORD

CheckToolInBackPack PROTO , Object : PTR Tool , CompareObject : PTR BACKPACK , CursorPosX : WORD , CursorPosY : WORD

PlaceToolInPackSlotMap PROTO , Object : PTR Tool , PackRecord : PTR BACKPACK , CursorPosX : WORD , CursorPosY : WORD

PlaceToolInPackToolList PROTO , Object : PTR Tool

ShowPackSuccessGraph PROTO
ShowPackNotSuccessGraph PROTO
ShowPackEraseGraph PROTO

ShowPackGraph PROTO , Source : PTR TEXT , _Length : WORD

ErasePackGraph PROTO

ShowSuccessPackGraph PROTO , Source : PTR TEXT , _Length : WORD

ENDIF