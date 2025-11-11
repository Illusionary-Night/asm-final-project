INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/display.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/DataType/Seller.inc

.data
	SellerToolBuf TOOL <>
	SellerCursor COORD <GOODSPOSITIONX,GOODSPOSITIONY>
	TestText Text <>
	TS1 BYTE "There is TOOL"
	ToolIndex BYTE 0
.code

ShowGoods proc uses esi eax ecx Shelf: PTR GOODS

	mov esi, Shelf
	INVOKE ShowRectangle, esi
	add esi, SIZEOF RECTANGLE
	mov ecx, MAXGOODS

	mov ax, GOODSPOSITIONX
	inc ax
	mov SellerCursor.X, ax

	mov ax, GOODSPOSITIONY
	inc ax
	mov SellerCursor.Y, ax
	
	L1:
		mov eax, [esi]
		cmp eax, 0
		je L2
		;INVOKE ......, OFFSET SellerToolBuf, [esi]		
		INVOKE SetText, OFFSET TestText, OFFSET TS1, 0Ah, SellerCursor, LENGTHOF TS1
		INVOKE ShowText, OFFSET TestText
		
		L2:
			add esi, 4
		
			mov ax, SellerCursor.Y
			inc ax
			mov SellerCursor.Y, ax
	LOOP L1

	ret 4

ShowGoods endp

EraseGoods proc uses esi Shelf: PTR GOODS

	mov esi, Shelf
	INVOKE EraseRectangle, esi
	add esi, SIZEOF RECTANGLE
	mov ecx, MAXGOODS

	mov ax, GOODSPOSITIONX
	inc ax
	mov SellerCursor.X, ax

	mov ax, GOODSPOSITIONY
	inc ax
	mov SellerCursor.Y, ax
	
	L1:
		mov eax, [esi]
		cmp eax, 0
		je L2
		;INVOKE ......, OFFSET SellerToolBuf, [esi]		
		INVOKE SetText, OFFSET TestText, OFFSET TS1, 0Ah, SellerCursor, LENGTHOF TS1
		INVOKE EraseText, OFFSET TestText
		
		L2:
			add esi, 4
		
			mov ax, SellerCursor.Y
			inc ax
			mov SellerCursor.Y, ax
	LOOP L1

	ret 4

EraseGoods endp

InsertTool proc uses esi eax ebx Shelf: PTR GOODS, UUID: BYTE

	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	movzx eax, ToolIndex
	mov bl, TYPE DWORD	
	mul bl
	add esi, eax
	mov al, UUID
	
	mov [esi], al	

	mov al, ToolIndex
	inc al
	mov ToolIndex, al

	ret 8

InsertTool endp

DeletTool proc Shelf: PTR GOODS, Index: BYTE

	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	movzx eax, Index
	mov bl, TYPE DWORD	
	mul bl
	add esi, eax
	mov al, 0
	
	mov [esi], al	

	ret 8

DeletTool endp

ShowToolInfo proc Shelf: PTR GOODS, Index: BYTE

ShowToolInfo endp

BuyTool proc Shelf: PTR GOODS, Index: BYTE

BuyTool endp



end