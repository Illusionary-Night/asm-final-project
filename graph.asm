INCLUDE Irvine32.inc
INCLUDE display.inc

.data
	GraphCursor COORD <0,0>
	;color WORD 07h
.code

SetText proc uses eax esi object: PTR TEXT, source: PTR BYTE, color: WORD, position: COORD, _length: WORD

	mov esi, object
	mov eax, source	
	mov [esi], eax

	mov ax, color
	mov [esi+4], ax
	
	mov eax, position
	mov [esi+6], eax
	
	mov ax, _length
	mov [esi+10], ax
	ret 20

SetText endp

ShowText proc uses eax bx esi object: PTR TEXT

	mov esi, object
	mov ax, [esi+4]
	INVOKE SetColor, ax
	
	mov eax, [esi+6]
	mov GraphCursor, eax
	INVOKE SetCursor, GraphCursor
	
	mov eax, [esi]
	mov bx, [esi+10]
	INVOKE PrintStr, eax, bx 
	INVOKE SetColor, 07h	

	ret 4

ShowText endp

EraseText proc uses eax bx esi object: PTR TEXT

	mov esi, object
	mov eax, [esi+6]
	mov GraphCursor, eax
	mov eax, [esi]
	mov bx, [esi+10]
	
	INVOKE SetColor, 0h
	INVOKE SetCursor, GraphCursor
	INVOKE PrintStr, eax, bx
	INVOKE SetColor, 07h

	ret 4

EraseText endp

end