.NOLIST
IFNDEF __BackPack
__BackPack EQU 1

BACKPACKWIDTH EQU 8
BACKPACKHEIGHT EQU 8
MAXSLOTS EQU BACKPACKWIDTH * BACKPACKHEIGHT


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

ENDIF