.NOLIST
IFNDEF __BackPack
__BackPack EQU 1

BACKPACK STRUCT
    BackPackWidth       WORD    ?
    BackPackHeight      WORD    ?
    SlotMap             BYTE    100 DUP(?)          ;0為空 1為滿

BACKPACK ENDS

InitBackPack PROTO , Object : PTR BACKPACK

DrawBackpack PROTO , BackPackBasPos : COORD

RecordIn PROTO , ToolPos : COORD

ENDIF