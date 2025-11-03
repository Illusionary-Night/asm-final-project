INCLUDE Irvine32.inc
INCLUDE display.inc
INCLUDE graph.inc

.data
	GraphCursor COORD <0,0>
	GraphStrBuf BYTE "                                                                                                                                                        ", 0Dh, 0Ah
	;color WORD 07h
.code

SetText proc uses eax esi ecx object: PTR TEXT, source: PTR BYTE, color: WORD, position: COORD, _length: WORD

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

ShowText proc uses eax bx esi ecx object: PTR TEXT

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

EraseText proc uses eax bx esi ecx object: PTR TEXT

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

SetRectangle proc uses eax esi ecx object: PTR RECTANGLE, element: BYTE, color: WORD, _width: WORD, _Hight: WORD, position: COORD

	mov esi, object
	mov al, element
	mov [esi], al
	
	mov ax, color
	mov [esi+1], ax

	mov ax, _width
	mov [esi+3], ax
	
	mov ax, _Hight
	mov [esi+5], ax

	mov eax, position
	mov [esi+7], eax
	ret 24

SetRectangle endp

ShowRectangle proc uses eax ecx ebx esi edi object: PTR RECTANGLE
	
	xor ecx, ecx
	xor ebx, ebx
	mov esi, object
	mov cx, [esi+5]
	mov bx, cx
	mov eax, [esi+7]
	mov GraphCursor, eax
	INVOKE SetCursor, GraphCursor
	mov ax, [esi+1]
	INVOKE SetColor, ax
	mov eax, OFFSET GraphStrBuf 
	mov edi, OFFSET GraphCursor	

	L1:
		INVOKE PrintStr, esi, 1
		cmp ecx,1 
		je L3
		cmp ecx, ebx
		je L3
		push ecx
		mov cx, [esi+3]
		sub cx, 2

		L2:
			INVOKE PrintStr, eax, 1
		loop L2
		jmp L5

		L3: 
			push ecx
			mov cx, [esi+3]
			sub cx, 2
		L4:
			INVOKE PrintStr, esi, 1
		loop L4

		L5:
			INVOKE PrintStr, esi, 1
			pop ecx
			push ebx
			mov bx, [edi+2]
			inc bx
			mov [edi+2], bx
			INVOKE SetCursor, GraphCursor
			pop ebx

	loop L1

	INVOKE SetColor, 07h
	ret 4

ShowRectangle endp

EraseRectangle proc object: PTR RECTANGLE

	xor ecx, ecx
	xor ebx, ebx
	mov esi, object
	mov edi, [esi]
	mov cx, [esi+5]
	mov bx, [esi+3]
	INVOKE SetColor, 00h
	mov eax, [esi+7]
	mov GraphCursor, eax
	INVOKE SetCursor, GraphCursor
	mov eax, OFFSET GraphStrBuf	
	mov esi, OFFSET GraphCursor

	L1:
		INVOKE PrintStr, eax, bx
		push ebx
		mov bx, [esi+2]
		inc bx
		mov [esi+2], bx
		INVOKE SetCursor, GraphCursor
		pop ebx
		
	loop L1

	INVOKE SetColor, 07h
	ret 4

EraseRectangle endp

SetPicture proc uses eax esi ecx Object: PTR PICTURE, Source: PTR BYTE, Color: WORD, _width: WORD, _Hight: WORD, Position: COORD,

	mov esi, object
	mov eax, source
	mov [esi], eax
	
	mov ax, color
	mov [esi+4], ax

	mov ax, _width
	mov [esi+6], ax
	
	mov ax, _Hight
	mov [esi+8], ax

	mov eax, position
	mov [esi+10], eax
	ret 24

SetPicture endp

ShowPicture proc uses eax esi edi ecx object: PTR PICTURE

	xor ecx, ecx
	xor ebx, ebx
	mov esi, object
	mov edi, [esi]
	mov cx, [esi+8]
	mov bx, [esi+6]
	mov ax, [esi+4]
	INVOKE SetColor, ax
	mov eax, [esi+10]
	mov GraphCursor, eax
	INVOKE SetCursor, GraphCursor	
	mov esi, OFFSET GraphCursor

	L1:
		INVOKE PrintStr, edi, bx
		add edi, ebx
		push ebx
		mov bx, [esi+2]
		inc bx
		mov [esi+2], bx
		INVOKE SetCursor, GraphCursor
		pop ebx
		
	loop L1

	INVOKE SetColor, 07h
	ret 4

ShowPicture endp

ErasePicture proc uses eax esi ecx edi object: PTR PICTURE
	
	xor ecx, ecx
	xor ebx, ebx
	mov esi, object
	mov edi, [esi]
	mov cx, [esi+8]
	mov bx, [esi+6]
	INVOKE SetColor, 00h
	mov eax, [esi+10]
	mov GraphCursor, eax
	INVOKE SetCursor, GraphCursor
	mov eax, OFFSET GraphStrBuf	
	mov esi, OFFSET GraphCursor

	L1:
		INVOKE PrintStr, eax, bx
		push ebx
		mov bx, [esi+2]
		inc bx
		mov [esi+2], bx
		INVOKE SetCursor, GraphCursor
		pop ebx
		
	loop L1

	INVOKE SetColor, 07h
	ret 4

ErasePicture endp


end