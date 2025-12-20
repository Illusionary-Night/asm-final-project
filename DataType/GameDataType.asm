INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc



.data
	; UI Dimensions
	FrameWidth   WORD 8		; Outer box width
	FrameHight   WORD 8		; Outer box height
	PicWidth     WORD 6		; Inner image width
	PicHight     WORD 6		; Inner image height
	FrameColor   WORD 07h	; Default color (Light Gray)
	FrameElement BYTE '*'	; Character used for borders
	BackPackPosition COORD<0,0>  ;背包最左上角的位置
.code

; ---------------------------------------------------------
; BpPositiontoRPosition
; Converts Backpack Grid Coords to Real Screen Coords.
; Formula: ScreenX = GridX * (FrameWidth - 1)
;          ScreenY = GridY * (FrameHeight - 1)
; Input: BpPosition (Pointer to COORD, modified in-place)
; ---------------------------------------------------------
BpPositiontoRPosition proc uses esi ebx ecx eax BpPosition: PTR COORD

	xor eax, eax
	xor ebx, ebx

	mov esi, BpPosition
	mov bx, (COORD PTR [esi]).X
	movzx eax,  FrameWidth
	dec eax			; Spacing adjustment (Width - 1)
	mul bl
	mov (COORD PTR [esi]).X, ax
	xor eax, eax
	mov bx, (COORD PTR [esi]).Y
	movzx eax,  FrameHight
	dec eax			; Spacing adjustment (Height - 1)
	mul bl
	;dec ax
	mov (COORD PTR [esi]).Y, ax
	ret 4

BpPositiontoRPosition endp

; ---------------------------------------------------------
; SetToolSlot
; Initializes the TOOLSLOT structure with frame and picture data.
; ---------------------------------------------------------
SetToolSlot proc uses esi eax ecx edi Object: PTR TOOLSLOT, Source: PTR BYTE, Color: WORD
	
	mov esi, Object

	; 1. Initialize Frame (Rectangle)
	INVOKE SetRectangle, esi, FrameElement, FrameColor, FrameWidth, FrameHight, BackPackPosition

	; 2. Initialize Picture (Offset by sizeof RECTANGLE, approx 11 bytes)
	add esi, 11
	INVOKE SetPicture, esi, Source, Color, PicWidth, PicHight, BackPackPosition  
	ret 12

SetToolSlot endp

; ---------------------------------------------------------
; ShowToolSlot
; Calculates screen position and renders the Frame and Picture.
; ---------------------------------------------------------
ShowToolSlot proc uses eax esi ecx edi Object: PTR TOOLSLOT, Position: COORD

	mov esi, Object
	lea edi, Position

	; 1. Convert Grid Coordinate to Screen Coordinate
	INVOKE BpPositiontoRPosition, edi

	; 2. Update Frame Position in Struct (Offset +7 is usually .Position in RECTANGLE)
	mov eax, [edi]
	mov [esi+7], eax

	; 3. Update Picture Position (Center it: ScreenCoord + 1)
	add WORD PTR [edi], 1
	add WORD PTR [edi+2], 1
	mov eax, [edi]
	mov [esi+21], eax		; Offset +21 is usually .Position in PICTURE (11 bytes for RECT + offset in PICTURE)

	; 4. Draw

	INVOKE ShowRectangle, esi
	add esi, 11
	INVOKE ShowPicture, esi
		
	ret 8

ShowToolSlot endp

; ---------------------------------------------------------
; Erase Functions
; Clears the specific part of the slot from the screen.
; ---------------------------------------------------------
EraseToolSlotPic proc uses esi ecx Object: PTR TOOLSLOT
	
	mov esi, Object
	add esi, 11			; Move to Picture struct
	INVOKE ErasePicture, esi
	ret 4

EraseToolSlotPic endp

EraseToolSlotFrame proc uses esi ecx Object: PTR TOOLSLOT

	mov esi, Object
	INVOKE EraseRectangle, esi
	ret 4

EraseToolSlotFrame endp

end