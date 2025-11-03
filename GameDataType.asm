INCLUDE Irvine32.inc
INCLUDE graph.inc

.data
	FrameWidth  WORD 8
	FrameHight WORD 8
.code

SetToolSlot proc uses esi eax ecx Object: PTR TOOLSLOT, Pic: PTR BYTE
	
	mov esi, Object
	mov eax, Pic
	mov [esi+11], eax
	mov [esi], '*'
	mov [esi+1], 07h
	mov [esi+3], FrameWidth
	mov [esi+5], FrameHight
	mov [esi+]	
 
	ret 8

SetToolSlot endp

ShowToolSlot proc object: PTR TOOLSLOT

	ret 4

ShowToolSlot endp

EraseToolSlotPic proc object: PTR TOOLSLOT

	ret 4

EraseToolSlotPic endp

EraseToolSlotFrame proc object: PTR TOOLSLOT

	ret 4

EraseToolSlotFrame endp

end