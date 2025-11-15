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
	GameBp BACKPACK <>	
	Seller GOODS <>
	OurGoods GOODS <<,,,,<OURGOODSPOSITIONX,GOODSPOSITIONY>>,,<,,,,<OURATTRIBUTEPOSITIONX,GOODSPOSITIONY>>,<,,,,<OURSHAPEPOSITIONX,GOODSPOSITIONY>>,<OURGOODSPOSITIONX,>,>
	CurGameStat GAMESTAT <0,0>
	GameStatCursor COORD <0,0>
	GameStatPicBuf PICTURE <>
	UserGoods DWORD MAXGOODS DUP(0)
	GameInputBuf BYTE 10 DUP(0)
.code

IntoStartStat proc uses esi eax	CurStat: PTR GAMESTAT

	mov esi, CurStat
	mov al, StartStat
	mov (GAMESTAT PTR [esi]).MainStat, al

	mov al, StartSceneStat
	mov (GAMESTAT PTR [esi]).SubStat, al

	INVOKE ShowTitle, GameStatCursor, OFFSET GameStatPicBuf

	ret

IntoStartStat endp

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

	L1:                                           ;choose which tool to sell
		INVOKE InsertTool, OFFSET Seller, 1
		inc al
	LOOP L1
	INVOKE ShowGoods, OFFSET Seller
	INVOKE ShowGoods, OFFSET OurGoods
	
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
	mov esi, OFFSET GameInputBuf
	cmp al, BuyStat
	call ReadChar
	je L1
	
	cmp al, PackStat
	je L2	

	L1:                         ;Buy Process, break untile user done
		mov ecx, 0
		mov eax, 0
		call ReadChar
		cmp al, ShowInst
		je ShowProcess
		cmp al, BuyInst
		je BuyProcess
		cmp al, EndInst
		je EndProcess	

		EndProcess: 
			mov ecx, 1
			jmp Dummy		
		ShowProcess:
			call ReadChar
			sub al, '0'
			INVOKE ShowToolInfo, OFFSET Seller, al
			jmp Dummy
		BuyProcess:
			call ReadChar
			sub al, '0'
			INVOKE BuyTool, OFFSET Seller, al
			INVOKE InsertTool, OFFSET OurGoods, eax
			INVOKE ShowGoods, OFFSET OurGoods
			INVOKE EraseToolInfo, OFFSET Seller
		Dummy:
	LOOP L1

	L2:                          ;Pack Process, break untile user done

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