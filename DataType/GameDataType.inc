.NOLIST
IFNDEF __GameDataType
__GameDataType EQU 1

INCLUDE ./asm-final-project/IO/graph.inc

; --- Data Structure ---
; Represents a single UI slot containing a border frame and an inner picture
TOOLSLOT STRUCT
	Frame RECTANGLE <>
	Pic  PICTURE <>
TOOLSLOT ENDS

; --- Prototypes ---

; Converts logic grid coordinates (e.g., 0,1) to screen coordinates

BpPositiontoRPosition PROTO,    
	BpPosition: PTR COORD

; Initializes a slot's graphical data (Frame + Picture)
SetToolSlot PROTO,
	Object:   PTR TOOLSLOT,
	Source:   PTR BYTE,
	Color: WORD   

; Renders the slot at a specific grid position
ShowToolSlot PROTO,
	Object: PTR TOOLSLOT,
	Position: COORD

; Cleanup functions
EraseToolSlotPic PROTO,
	Object: PTR TOOLSLOT

EraseToolSlotFrame PROTO,
	Object: PTR TOOLSLOT

ENDIF