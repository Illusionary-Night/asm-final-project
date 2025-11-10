.NOLIST

BACKPACK STRUCT
    BackPackWidth       WORD    ?
    BackPackHeight      WORD    ?
    SlotMap             BYTE    100 DUP(?)          ;0為空 1為滿
    BasePosition        COORD   <>
    ToolsPtr            DWORD   ?

BACKPACK ENDS

InitBackPack PROTO, PtrBackPack : PTR BACKPACK , basePos : COORD

ShowBackPack PROTO, PtrBackPack : PTR BACKPACK

EraseBackPack PROTO , PtrBackPack : PTR BACKPACK