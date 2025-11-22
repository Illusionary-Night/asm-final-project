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

.data

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
	je Conflict

	INVOKE RecordInBackPack, OurBp, (TOOL PTR [esi]).BPPOSITION
	INVOKE ShowTool, Target
	INVOKE DeletTool, Shelf, bl
	jmp Dummy	

	Conflict:               ;you can show some text here
	Dummy:

	ret

RunPackProcess endp


end