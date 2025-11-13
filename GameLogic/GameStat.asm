INCLUDE ./asm-final-project/SysInc/Irvine32.inc

INCLUDE ./asm-final-project/IO/display.inc
INCLUDE ./asm-final-project/IO/graph.inc

INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/DataType/Seller.inc
INCLUDE ./asm-final-project/DataType/BackPack.inc
INCLUDE ./asm-final-project/ToolInfo.inc

INCLUDE ./asm-final-project/GameLogic/GameStat.inc
INCLUDE ./asm-final-project/GameLogic/GameClock.inc
INCLUDE ./asm-final-project/GameLogic/GameControler.inc


.data
	GameBp BACKPACK <>	
	Seller GOODS <>
	CurGameStat GAMESTAT <0,0>
	GameStatCursor COORD <0,0>
.code

IntoPrepareStat proc uses esi eax ecx CurStat: PTR GAMESTAT

	mov esi, CurStat
	mov al, PrepareStat
	mov (GAMESTAT PTR [esi]).MainStat, al

	mov al, BuyStat
	mov (GAMESTAT PTR [esi]).SubStat, al

	INVOKE InitBackPack, OFFSET GameBp
	INVOKE ShowBackpack, GameStatCursor
	
	mov ecx, 5
	mov eax, 0	

	L1:
		INVOKE InsertTool, OFFSET Seller, al
		inc al
	LOOP L1
	INVOKE ShowGoods, OFFSET Seller
	
	ret 4

IntoPrepareStat endp

IntoFightStat proc uses esi eax CurStat: PTR GAMESTAT

	mov esi, CurStat
	mov al, FightStat
	mov (GAMESTAT PTR [esi]).MainStat, al

	mov al, SelfStat
	mov (GAMESTAT PTR [esi]).SubStat, al
	ret 4

IntoFightStat endp

CheStartSubStat proc uses esi eax CurStat: PTR GAMESTAT, SubStat: BYTE

	mov esi, CurStat

	mov al, SubStat
	mov (GAMESTAT PTR [esi]).SubStat, al
	INVOKE clear_screen
		
	ret 8

CheStartSubStat endp

ChePrepareSubStat proc uses esi eax ecx CurStat: PTR GAMESTAT, SubStat: BYTE
	
	mov esi, CurStat
	mov al, SubStat
	mov (GAMESTAT PTR [esi]).SubStat, al

	xor ecx, ecx
	mov ecx, 3
	mov eax, 0
	
	cmp al, BuyStat
	je L1
	
	cmp al, PackStat
	je L2	

	L1:
		;input
		INVOKE ShowToolInfo, OFFSET Seller, al
		DelayXms 800
		INVOKE BuyTool, OFFSET SELLER, al
		DelayXms 800
		INVOKE EraseToolInfo, OFFSET Seller
		DelayXms 800
		inc al
		;mov ecx, 0
	LOOP L1

	L2:

	LOOP L2

	ret

ChePrepareSubStat endp

CheFightSubStat proc uses esi eax CurStat: PTR GAMESTAT, SubStat: BYTE
	
	mov esi, CurStat
	mov al, SubStat
	mov (GAMESTAT PTR [esi]).SubStat, al
		
	ret 8

CheFightSubStat endp

end