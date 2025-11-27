INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/display.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/ToolInfo.inc
INCLUDE ./asm-final-project/DataType/Seller.inc

.data
	SellerToolBuf TOOL <>
	SellerCursor COORD <GOODSPOSITIONX,GOODSPOSITIONY>
	SellerStrBuf BYTE 10 DUP(0)
	RarityStr  	BYTE "Rarity: "
	CoolDownTimeStr BYTE "CoolDownTime: "
	TypeStr		BYTE "Type: "
	HpStr		BYTE "Hp: "
	EpStr		BYTE "Sp: "
	MpStr		BYTE "Mp: "
	ShieldStr	Byte "Shield: "
	TestText Text <>
	TS1 BYTE "There is TOOL"
.code

ShowGoods proc uses esi eax ecx Shelf: PTR GOODS

	mov esi, Shelf
	INVOKE ShowRectangle, esi

	mov ecx, MAXGOODS
	
	mov esi, Shelf
	SetSellerCursor (GOODS PTR [esi]).Position.X, (GOODS PTR [esi]).Position.Y

	add esi, SIZEOF RECTANGLE
	
	L1:
		mov eax, [esi]
		cmp eax, 0
		je L2
		INVOKE GetToolByUUID, OFFSET SellerToolBuf, eax		
		;INVOKE SetText, OFFSET TestText, OFFSET SellerToolBuf.TOOLNAME, 0Ah, SellerCursor, LENGTHOF SellerToolBuf.TOOLNAME
		;INVOKE ShowText, OFFSET TestText
		
		; 取得 TOOLNAME 位址
		lea esi, SellerToolBuf.TOOLNAME

		; 設定 TestText
		INVOKE SetText, OFFSET TestText, esi, 0Ah, SellerCursor, 20  ; 或用 strlen 取得真正長度
		INVOKE ShowText, OFFSET TestText
		L2:
			add esi, 4
			AddSellerCursorY 1
	LOOP L1

	ret 4

ShowGoods endp

EraseGoods proc uses esi ecx eax Shelf: PTR GOODS

	mov esi, Shelf
	INVOKE EraseRectangle, esi
	mov ecx, MAXGOODS
	
	mov eax, 0
	SetSellerCursor (GOODS PTR [esi]).Position.X, (GOODS PTR [esi]).Position.Y
	
	L1:
		INVOKE SetText, OFFSET TestText, OFFSET TS1, 0Ah, SellerCursor, GOODSFRAMEWIDTH
		INVOKE EraseText, OFFSET TestText
		AddSellerCursorY 1
	LOOP L1

	ret 4

EraseGoods endp

InsertTool proc uses esi eax ebx ecx Shelf: PTR GOODS, UUID: DWORD

	mov esi, Shelf
	mov ecx, MAXGOODS
	add esi, SIZEOF RECTANGLE

	L1:
		mov eax, [esi]
		cmp eax, 0
		jne Dummy
		
		Done:
			mov eax, UUID
			mov [esi], eax
			mov ecx, 1
		Dummy:
			add esi, SIZEOF DWORD
	LOOP L1
	ret

InsertTool endp

DeletTool proc uses esi eax ebx ecx Shelf: PTR GOODS, Index: BYTE	

	mov esi, Shelf
	SetSellerCursor (GOODS PTR [esi]).Position.X, (GOODS PTR [esi]).Position.Y
	movzx ebx, Index
	AddSellerCursorY bx
	INVOKE SetText, OFFSET TestText, OFFSET TS1, 0Ah, SellerCursor, GOODSFRAMEWIDTH
	INVOKE EraseText, OFFSET TestText

	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	movzx eax, Index
	mov bl, TYPE DWORD	
	mul bl
	add esi, eax
	mov eax, 0
	
	mov [esi], eax	

	ret

DeletTool endp

ResetAllToolInGoods proc uses eax esi ecx Shelf: PTR GOODS
	
	mov ecx, MAXGOODS
	mov eax, 0
	L1:
		INVOKE DeletTool, Shelf, al
		inc al
	LOOP L1
	mov eax, 0
	mov esi, Shelf
	mov (GOODS PTR [esi]).ToolIndex, al
	ret

ResetAllToolInGoods endp

ShowToolInfo proc uses eax esi edi ebx ecx Shelf: PTR GOODS, Index: BYTE

	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	mov eax, SIZEOF (GOODS PTR [esi]).UUID
	add esi, eax

	INVOKE ShowRectangle, esi
	add esi, SIZEOF RECTANGLE
	INVOKE ShowRectangle, esi

	INVOKE TakeTool, Shelf, OFFSET SellerToolBuf, Index	
	xor eax, eax
	xor ebx, ebx
	mov ecx, SHAPESIZE

	mov esi, Shelf
	mov ax, (GOODS PTR [esi]).Position.X
	sub ax, SHAPESIZE
	dec ax
	SetSellerCursor ax, (GOODS PTR [esi]).Position.Y

	mov eax, 0

	L1:
		push ecx
		mov ecx, SHAPESIZE
		mov esi, OFFSET SellerStrBuf	
		L2:
			mov bl, SellerToolBuf.SHAPE[eax]
			mov [esi], bl

			inc eax
			inc esi		
		LOOP L2
		pop ecx
		INVOKE SetText, OFFSET TestText, OFFSET SellerStrBuf, 0Ah, SellerCursor, SHAPESIZE
		INVOKE ShowText, OFFSET TestText
		AddSellerCursorY 1
	LOOP L1

	mov esi, Shelf
	mov ax, (GOODS PTR [esi]).Position.X
	add ax, GOODSFRAMEWIDTH
	inc ax
	SetSellerCursor ax, (GOODS PTR [esi]).Position.Y

	mov esi, OFFSET SellerToolBuf
	xor eax, eax

	INVOKE SetText, OFFSET TestText, OFFSET RarityStr, 0Ah, SellerCursor, LENGTHOF RarityStr
	INVOKE ShowText, OFFSET TestText
	mov al, (TOOL PTR [esi]).RARITY
	call WriteInt
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET CoolDownTimeStr, 0Ah, SellerCursor, LENGTHOF CoolDownTimeStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).COOLDOWNMAX
	call WriteInt
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET TypeStr, 0Ah, SellerCursor, LENGTHOF TypeStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).TYPEID
	call WriteInt
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET HpStr, 0Ah, SellerCursor, LENGTHOF HpStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).ALLYDELTA.HP
	call WriteInt
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET EpStr, 0Ah, SellerCursor, LENGTHOF EpStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).ALLYDELTA.EP
	call WriteInt
	AddSellerCursorY 1

	INVOKE SetText, OFFSET TestText, OFFSET MpStr, 0Ah, SellerCursor, LENGTHOF MpStr
	INVOKE ShowText, OFFSET TestText
	mov eax, (TOOL PTR [esi]).ALLYDELTA.MP
	call WriteInt
	AddSellerCursorY 1
	
	
	ret

ShowToolInfo endp

EraseToolInfo proc uses eax esi edi ebx ecx Shelf: PTR GOODS
	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	mov eax, SIZEOF (GOODS PTR [esi]).UUID
	add esi, eax

	INVOKE EraseRectangle, esi

	add esi, SIZEOF RECTANGLE
	INVOKE EraseRectangle, esi

	xor eax, eax
	xor ebx, ebx
	mov ecx, SHAPESIZE

	mov esi, Shelf
	mov ax, (GOODS PTR [esi]).Position.X
	sub ax, SHAPESIZE
	dec ax
	SetSellerCursor ax, (GOODS PTR [esi]).Position.Y

	L1:
		INVOKE SetText, OFFSET TestText, OFFSET SellerStrBuf, 0Ah, SellerCursor, SHAPESIZE
		INVOKE EraseText, OFFSET TestText
		AddSellerCursorY 1
	LOOP L1

	xor eax, eax

	mov ax, (GOODS PTR [esi]).Position.X
	add ax, GOODSFRAMEWIDTH
	inc ax
	SetSellerCursor ax, (GOODS PTR [esi]).Position.Y

	mov ecx, ATTRIBUTEHIGHT
	
	L2:
		INVOKE SetText, OFFSET TestText, OFFSET RarityStr, 0Ah, SellerCursor, ATTRIBUTEWIDTH
		INVOKE EraseText, OFFSET TestText
		AddSellerCursorY 1
	LOOP L2

	mov esi, Shelf
	INVOKE ShowGoods, esi
		
	ret
EraseToolInfo endp

BuyTool proc uses esi ecx ebx Shelf: PTR GOODS, Index: BYTE
	
	mov esi, Shelf
	add esi, SIZEOF RECTANGLE
	movzx eax, Index
	mov bl, TYPE DWORD	
	mul bl
	add esi, eax
	mov eax, [esi]
	
	push eax
	INVOKE DeletTool, Shelf, Index
	pop eax
	ret

BuyTool endp

TakeTool proc uses ecx eax esi ebx Shelf: PTR GOODS, TargetTool: PTR TOOL, Index: BYTE	

	xor eax, eax
	xor ebx, ebx
	mov esi, Shelf
	add esi, SIZEOF RECTANGLE

	movzx eax, Index
	mov bl, TYPE DWORD
	mul bl
	add esi, eax
	mov eax, [esi]

	INVOKE GetToolByUUID, TargetTool, eax
	ret

TakeTool endp

end