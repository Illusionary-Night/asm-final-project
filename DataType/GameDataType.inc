.NOLIST

TOOLSLOT STRUCT
	Frame RECTANGLE <>
	Pic  PICTURE <>
TOOLSLOT ENDS

BpPositiontoRPosition PROTO,    ;this function will return a RealPosition in eax
	BpPosition: COORD

SetToolSlot PROTO,
	Object:   PTR TOOLSLOT,
	Source:   PTR BYTE,
	Color: WORD   

ShowToolSlot PROTO,
	Object: PTR TOOLSLOT,
	Position: COORD

EraseToolSlotPic PROTO,
	Object: PTR TOOLSLOT

EraseToolSlotFrame PROTO,
	Object: PTR TOOLSLOT


