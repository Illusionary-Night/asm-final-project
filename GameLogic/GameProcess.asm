INCLUDE ./asm-final-project/SysInc/Irvine32.inc

INCLUDE ./asm-final-project/IO/display.inc
INCLUDE ./asm-final-project/IO/input.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/IO/StartScene.inc
INCLUDE ./asm-final-project/IO/FightScene.inc

INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/DataType/Seller.inc
INCLUDE ./asm-final-project/DataType/BackPack.inc
INCLUDE ./asm-final-project/ToolInfo.inc

INCLUDE ./asm-final-project/GameLogic/GameStat.inc
INCLUDE ./asm-final-project/GameLogic/GameClock.inc
INCLUDE ./asm-final-project/GameLogic/GameControler.inc
INCLUDE ./asm-final-project/GameLogic/GameKey.inc
INCLUDE ./asm-final-project/GameLogic/GameProcess.inc


.data
	UserHpStr	BYTE "Hp: "
	UserEpStr	BYTE "Sp: "
	UserMpStr	BYTE "Mp: "
	UserMoneyStr    BYTE "Money: "
	UserLivesStr    BYTE "Lives: "
	GameProcessCursor COORD <>;<UserAttributeX,UserAttributeY>
	GameProcessText TEXT <>
	ToolListInBackPack DWORD ?
	ToolCountInBackPack DWORD ?
	Msg_ProcessPeriodicTools BYTE "Processing periodic tools...",0Ah,0Dh,"$"
.code

RunPackProcess PROC uses esi eax ebx ecx OurBp: PTR BACKPACK, Shelf: PTR GOODS, Target: PTR TOOL
	
	xor eax, eax
	mov esi, Target

	INVOKE ShowPackEraseGraph
	
	INVOKE ReadInt09
	mov bl, al
	INVOKE TakeTool, shelf, Target, al

	INVOKE ReadInt09
	mov (TOOL PTR [esi]).BPPOSITION.X, ax
	INVOKE ReadInt09
	mov (TOOL PTR [esi]).BPPOSITION.Y, ax

	xor eax , eax
	INVOKE CheckToolInBackPack , Target , OurBp , (TOOL PTR [esi]).BPPOSITION.X , (TOOL PTR [esi]).BPPOSITION.Y
	cmp al, 0
	je Conflict
	
	INVOKE PlaceToolInPackSlotMap , Target , OurBp , (TOOL PTR [esi]).BPPOSITION.X , (TOOL PTR [esi]).BPPOSITION.Y
	INVOKE ShowTool, Target
	INVOKE DeletTool, Shelf, bl
	INVOKE PlaceToolInPackToolList , Target
	INVOKE ShowPackSuccessGraph
	INVOKE EraseToolInfo, Shelf
	jmp Dummy	

	Conflict:               ;you can show some text here
	INVOKE ShowPackNotSuccessGraph
	jmp Dummy
	Dummy:

	ret

RunPackProcess endp

RunBuyProcess proc uses eax esi edi ebx edx Shelf1: PTR GOODS, Shelf2: PTR GOODS, Char: PTR CHARACTERATTRIBUTE, Position: COORD, Target: PTR TOOL

	INVOKE ReadInt09
	mov edi, Target
	mov bl, al
	INVOKE TakeTool, Shelf1, Target, al
	mov edx, (TOOL PTR [edi]).PRICE
	INVOKE CheckMoneyEnough, Char, edx  ;Assume all tool is 25 dollars
	cmp eax, 1
	jne Done
	mov esi, Char
	sub (CHARACTERATTRIBUTE PTR [esi]).Resource.MONEY, edx

	mov al, bl
	INVOKE EraseCharInfo, Char, Position 
	INVOKE ShowCharInfo, Char, Position 

	INVOKE ShowCharInfo, Char, Position
	INVOKE BuyTool, Shelf1, al
	INVOKE InsertTool, Shelf2, eax
	INVOKE ShowGoods, Shelf2
	INVOKE EraseToolInfo, Shelf1
	Done:

	ret

RunBuyProcess endp


; Assume Enemy attack user 150

RunFightProcess proc uses esi edi ebx edx AllyChar: PTR CHARACTERATTRIBUTE, EnemyChar: PTR CHARACTERATTRIBUTE, Position: COORD

	mov esi, AllyChar
	mov edi, EnemyChar
	;user don't need to attack directly
	sub (CHARACTERATTRIBUTE PTR [esi]).Ingame.HP, 100; enemy attack user
	
	;cyclical tool active--------------------------
	INVOKE GetToolListPtrInBackPack
	mov ToolListInBackPack, ebx
	mov ToolCountInBackPack, edx
	INVOKE ProcessPeriodicTools , esi, edi
	;----------------------------------------------
	
	mov eax, (CHARACTERATTRIBUTE PTR [edi]).Ingame.HP
	cmp eax, 0
	jle UserWin
	
	mov eax, (CHARACTERATTRIBUTE PTR [esi]).Ingame.HP
	cmp eax, 0
	jle UserLose
	mov eax, 0
	jmp Done

	UserWin:
		mov eax, (CHARACTERATTRIBUTE PTR [edi]).Resource.MONEY
		add (CHARACTERATTRIBUTE PTR [esi]).Resource.MONEY, eax
		mov eax, 1
		jmp Done
	UserLose:
		dec (CHARACTERATTRIBUTE PTR [esi]).Resource.LIVES
		mov eax, 1
	Done:
		INVOKE EraseCharInfo, AllyChar, Position
		INVOKE EraseCharInfoGraph, AllyChar, Position
		INVOKE ShowCharInfo, AllyChar, Position
		INVOKE ShowCharInfoGraph, AllyChar, Position

		add Position.X, EnemyInfoPositionX-UserInfoPositionX
		INVOKE EraseCharInfo, EnemyChar, Position
		INVOKE EraseCharInfoGraph, EnemyChar, Position
		INVOKE ShowCharInfo, EnemyChar, Position
		INVOKE ShowCharInfoGraph, EnemyChar, Position

	ret

RunFightProcess endp

; ProcessPeriodicTools:  M   D  } C A B z g   N o
ProcessPeriodicTools PROC USES esi edi eax ebx ecx edx AllyChar: PTR CHARACTERATTRIBUTE, EnemyChar: PTR CHARACTERATTRIBUTE
    mov esi, ToolListInBackPack       ; ESI    V Ĥ@ ӹD  
    mov ecx, ToolCountInBackPack	; ECX =  } C    


    cmp ecx, 0
    je DoneLoop

NextTool:
    ; -------------------------------
    push edx
	mov dh, 50       
	add edx, ecx
	add edx, ecx
	add edx, ecx
	add edx, ecx

	mov dl, 150       
	call Gotoxy       
	pop edx

	push eax
	mov eax, ecx
	call WriteInt
	pop eax

	push edx
	mov edx, ecx
	add dh, 50       
	mov dl, 160       
	call Gotoxy       
	pop edx

	push eax
	mov eax, (TOOL PTR [esi]).COOLDOWN
	call WriteInt
	pop eax
	;--------------------------------

	INVOKE CooldownUpdate_Tool, esi
	cmp eax, 0
	je SkipTool	;original jne

    ; -------------------------------
    ; TODO: invoke some function or trigger effect
	lea ebx, (TOOL PTR [esi]).ALLYDELTA
	mov edi, AllyChar                       ; EDI = pointer to CHARACTERATTRIBUTE
	;lea edi, (CHARACTERATTRIBUTE PTR [edi]).Ingame   ; EDI = &AllyChar.Ingame
	INVOKE OverlayInGameAttribute, edi, ebx, 0
	cmp eax, 0
	jne SkipTool
	lea ebx, (TOOL PTR [esi]).ENEMYDELTA
	mov edi, EnemyChar                      ; EDI = pointer to CHARACTERATTRIBUTE
	;lea edi, (CHARACTERATTRIBUTE PTR [edi]).Ingame   ; EDI = &EnemyChar.Ingame
	INVOKE OverlayInGameAttribute, edi, ebx, 1
    ; -------------------------------
    

SkipTool:
    add esi, SIZEOF TOOL     ;     U @ ӹD  
    loop NextTool

DoneLoop:
    ret
ProcessPeriodicTools ENDP

end