INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc



.data
	FrameWidth   WORD 8
	FrameHight   WORD 8
	PicWidth     WORD 6
	PicHight     WORD 6
	FrameColor   WORD 07h
	FrameElement BYTE '*'
	BackPackPosition COORD<0,0>  ;背包最左上角的位置
.code

BpPositiontoRPosition proc uses esi ebx ecx eax BpPosition: PTR COORD

	xor eax, eax
	xor ebx, ebx

	mov esi, BpPosition
	mov bx, (COORD PTR [esi]).X
	movzx eax,  FrameWidth
	dec eax
	mul bl
	mov (COORD PTR [esi]).X, ax
	xor eax, eax
	mov bx, (COORD PTR [esi]).Y
	movzx eax,  FrameHight
	dec eax
	mul bl
	;dec ax
	mov (COORD PTR [esi]).Y, ax
	ret 4

BpPositiontoRPosition endp


SetToolSlot proc uses esi eax ecx edi Object: PTR TOOLSLOT, Source: PTR BYTE, Color: WORD
	
	mov esi, Object
	INVOKE SetRectangle, esi, FrameElement, FrameColor, FrameWidth, FrameHight, BackPackPosition
	add esi, 11
	INVOKE SetPicture, esi, Source, Color, PicWidth, PicHight, BackPackPosition  
	ret 12

SetToolSlot endp

ShowToolSlot proc uses eax esi ecx edi Object: PTR TOOLSLOT, Position: COORD

	mov esi, Object
	lea edi, Position
	INVOKE BpPositiontoRPosition, edi
	mov eax, [edi]
	mov [esi+7], eax
	add WORD PTR [edi], 1
	add WORD PTR [edi+2], 1
	mov eax, [edi]
	mov [esi+21], eax

	INVOKE ShowRectangle, esi
	add esi, 11
	INVOKE ShowPicture, esi
		
	ret 8

ShowToolSlot endp

EraseToolSlotPic proc uses esi ecx Object: PTR TOOLSLOT
	
	mov esi, Object
	add esi, 11
	INVOKE ErasePicture, esi
	ret 4

EraseToolSlotPic endp

EraseToolSlotFrame proc uses esi ecx Object: PTR TOOLSLOT

	mov esi, Object
	INVOKE EraseRectangle, esi
	ret 4

EraseToolSlotFrame endp

end