.NOLIST

TOOLSLOT STRUCT
	Frame    RECTANGLE <>
	Pic  PICTURE <>
TOOLSLOT ENDS

SetToolSlot PROTO,
	Object:   PTR TOOLSLOT,
	Pic:   PTR PICTURE,   

ShowToolSlot PROTO,
	object: PTR TOOLSLOT

EraseToolSlotPic PROTO,
	object: PTR TOOLSLOT

EraseToolSlotFrame PROTO,
	object: PTR TOOLSLOT


