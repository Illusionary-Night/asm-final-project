INCLUDE ./asm-final-project/SysInc/Irvine32.inc

INCLUDE ./asm-final-project/IO/display.inc
INCLUDE ./asm-final-project/IO/input.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/IO/StartScene.inc

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
	
.code

RunPackProcess PROC uses esi eax ebx OurBp: PTR BACKPACK, Shelf: PTR GOODS, Target: PTR TOOL
	
	xor eax, eax
	mov esi, Target
	
	INVOKE ReadInt09
	mov bl, al
	INVOKE TakeTool, shelf, Target, al

	INVOKE ReadInt09
	mov (TOOL PTR [esi]).BPPOSITION.X, ax
	INVOKE ReadInt09
	mov (TOOL PTR [esi]).BPPOSITION.Y, ax

	INVOKE CheckBackPackRecord, OurBp, (TOOL PTR [esi]).BPPOSITION
	cmp al, 1
	;je Conflict

	INVOKE RecordInBackPack, OurBp, (TOOL PTR [esi]).BPPOSITION
	INVOKE ShowTool, Target
	INVOKE DeletTool, Shelf, bl
	jmp Dummy	

	Conflict:               ;you can show some text here
	Dummy:

	ret

RunPackProcess endp

RunBuyProcess proc uses eax esi ebx Shelf1: PTR GOODS, Shelf2: PTR GOODS, Char: PTR CHARACTERATTRIBUTE, Position: COORD

	INVOKE ReadInt09
	mov bl, al
	INVOKE CheckMoneyEnough, Char, 25  ;Assume all tool is 25 dollars
	cmp eax, 1
	jne Done
	mov al, bl
	mov esi, Char
	sub (CHARACTERATTRIBUTE PTR [esi]).Resource.MONEY, 25

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


; Assume user attack enemy 200, Enemy attack user 150

RunFightProcess proc uses esi edi Char1: PTR CHARACTERATTRIBUTE, Char2: PTR CHARACTERATTRIBUTE, Position: COORD

	mov esi, Char1
	mov edi, Char2
	sub (CHARACTERATTRIBUTE PTR [edi]).Ingame.HP, 200
	sub (CHARACTERATTRIBUTE PTR [esi]).Ingame.HP, 150

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
		INVOKE EraseCharInfo, Char1, Position
		INVOKE ShowCharInfo, Char1, Position

		add Position.X, 40
		INVOKE EraseCharInfo, Char2, Position
		INVOKE ShowCharInfo, Char2, Position
	ret

RunFightProcess endp

ShowCharInfo proc uses eax esi Char: PTR CHARACTERATTRIBUTE, Position: COORD
	
	mov esi, Char
	SetGameProcessCursor Position.X, Position.Y

	INVOKE SetText, OFFSET GameProcessText, OFFSET UserHpStr, 0Ah, GameProcessCursor, LENGTHOF UserHpStr
	INVOKE ShowText, OFFSET GameProcessText
	mov eax, (CHARACTERATTRIBUTE PTR [esi]).Ingame.HP
	call WriteInt
	inc GameProcessCursor.Y

	INVOKE SetText, OFFSET GameProcessText, OFFSET UserEpStr, 0Ah, GameProcessCursor, LENGTHOF UserEpStr
	INVOKE ShowText, OFFSET GameProcessText
	mov eax, (CHARACTERATTRIBUTE PTR [esi]).Ingame.EP
	call WriteInt
	inc GameProcessCursor.Y

	INVOKE SetText, OFFSET GameProcessText, OFFSET UserMpStr, 0Ah, GameProcessCursor, LENGTHOF UserMpStr
	INVOKE ShowText, OFFSET GameProcessText
	mov eax, (CHARACTERATTRIBUTE PTR [esi]).Ingame.MP
	call WriteInt
	inc GameProcessCursor.Y

	INVOKE SetText, OFFSET GameProcessText, OFFSET UserMoneyStr, 0Ah, GameProcessCursor, LENGTHOF UserMoneyStr
	INVOKE ShowText, OFFSET GameProcessText
	mov eax, (CHARACTERATTRIBUTE PTR [esi]).Resource.MONEY
	call WriteInt
	inc GameProcessCursor.Y

	INVOKE SetText, OFFSET GameProcessText, OFFSET UserLivesStr, 0Ah, GameProcessCursor, LENGTHOF UserLivesStr
	INVOKE ShowText, OFFSET GameProcessText
	mov eax, (CHARACTERATTRIBUTE PTR [esi]).Resource.LIVES
	call WriteInt
	inc GameProcessCursor.Y

	ret

ShowCharInfo endp

EraseCharInfo proc uses eax esi ecx Char: PTR CHARACTERATTRIBUTE, Position: COORD

	mov ecx, 5
	SetGameProcessCursor Position.X, Position.Y
	L1:
		INVOKE SetText, OFFSET GameProcessText, OFFSET UserMoneyStr, 0Ah, GameProcessCursor, 15
		INVOKE EraseText, OFFSET GameProcessText
		inc GameProcessCursor.Y
	LOOP L1
	ret 

EraseCharInfo endp

end