.NOLIST
IFNDEF __BackPack
__BackPack EQU 1

BACKPACK STRUCT
    BackPackWidth       WORD    ?
    BackPackHeight      WORD    ?
    SlotMap             BYTE    100 DUP(?)          ;0為空 1為滿

BACKPACK ENDS

DrawBackpack PROTO, BackPackBasPos : COORD

ENDIF