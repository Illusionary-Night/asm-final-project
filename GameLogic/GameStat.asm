INCLUDE ./asm-final-project/SysInc/Irvine32.inc

INCLUDE ./asm-final-project/IO/display.inc
INCLUDE ./asm-final-project/IO/input.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/IO/StartScene.inc
INCLUDE ./asm-final-project/IO/StageGraph.inc
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
	GameBp 		BACKPACK <>	
	Seller		GOODS <>
	OurGoods 	GOODS <<,,,,<OURGOODSPOSITIONX,GOODSPOSITIONY>>,,<,,,,<OURATTRIBUTEPOSITIONX,GOODSPOSITIONY>>,<,,,,<OURSHAPEPOSITIONX,GOODSPOSITIONY>>,<OURGOODSPOSITIONX,>,>
	CurGameStat 	GAMESTAT <0,0>
	GameStatCursor 	COORD <0,0>
	GameStatPicBuf 	PICTURE <>
	UserGoods 	DWORD MAXGOODS DUP(0)
	GameInputBuf 	BYTE 10 DUP(0)
	GameStatToolBuf TOOL <>

	User         CHARACTERATTRIBUTE <>
	Enemy	     CHARACTERATTRIBUTE <>
.code

; ------------------------------------------------------------
; Enter Start State
; ------------------------------------------------------------
IntoStartStat proc uses esi eax	CurStat: PTR GAMESTAT

	mov esi, CurStat
	mov al, StartStat
	mov (GAMESTAT PTR [esi]).MainStat, al

	mov al, StartSceneStat
	mov (GAMESTAT PTR [esi]).SubStat, al

	INVOKE ShowTitle, GameStatCursor, OFFSET GameStatPicBuf
	INVOKE InitializeResourceAttribute, OFFSET User.Resource
	INVOKE InitializeInGameAttribute, OFFSET User.InGame

	INVOKE InitBackPack , OFFSET GameBp

	ret

IntoStartStat endp

; ------------------------------------------------------------
; Enter Prepare State (Buy / Pack)
; ------------------------------------------------------------
IntoPrepareStat proc uses esi eax ecx CurStat: PTR GAMESTAT

	;INVOKE clear_screen
	mov esi, CurStat
	mov al, PrepareStat
	mov (GAMESTAT PTR [esi]).MainStat, al

	mov al, BuyStat
	mov (GAMESTAT PTR [esi]).SubStat, al
	
	
	INVOKE ResetAllToolInGoods, OFFSET Seller
												;choose which tool to sell
	INVOKE InsertTool, OFFSET Seller, 2
	INVOKE InsertTool, OFFSET Seller, 3
	INVOKE InsertTool, OFFSET Seller, 4
	INVOKE InsertTool, OFFSET Seller, 5
	INVOKE ShowGoods, OFFSET Seller
	INVOKE ShowGoods, OFFSET OurGoods
	
	mov ax, UserInfoPositionX
	mov GameStatCursor.X, ax
	mov ax, UserInfoPositionY
	mov GameStatCursor.Y, ax
	
	INVOKE ShowCharInfo, OFFSET User, GameStatCursor
	
	ret 4

IntoPrepareStat endp

; ------------------------------------------------------------
; Enter Fight State
; ------------------------------------------------------------
IntoFightStat proc uses esi eax CurStat: PTR GAMESTAT

	mov esi, CurStat
	mov al, FightStat
	mov (GAMESTAT PTR [esi]).MainStat, al

	mov al, SelfStat
	mov (GAMESTAT PTR [esi]).SubStat, al
	INVOKE EraseStageGraph
	;INVOKE ShowStage, CurStat

	; Initialize enemy and reset user in-game stats
	INVOKE InitializeResourceAttribute, OFFSET Enemy.Resource
	INVOKE InitializeInGameAttribute, OFFSET Enemy.InGame

	INVOKE InitializeInGameAttribute, OFFSET User.InGame	;---------------------------- I think we also need to re-initialize user InGame attribute here

	; Clear shop UI
	INVOKE EraseToolInfo, OFFSET Seller
	INVOKE EraseToolInfo, OFFSET OurGoods
	INVOKE EraseGoods, OFFSET Seller
	INVOKE EraseGoods, OFFSET OurGoods

	; Show user info and image
	mov ax, UserInfoPositionX
	mov GameStatCursor.X, ax
	mov ax, UserInfoPositionY
	mov GameStatCursor.Y, ax	;move cursor to UserInfoPosition
	INVOKE ShowCharInfoGraph, OFFSET User, GameStatCursor
	INVOKE ShowAllyImage, GameStatCursor
	
	; Show enemy info and image
	add GameStatCursor.X, EnemyInfoPositionX-UserInfoPositionX
	INVOKE ShowCharInfo, OFFSET Enemy, GameStatCursor	;move cursor to EnemyInfoPositionX
	INVOKE ShowCharInfoGraph, OFFSET Enemy, GameStatCursor
	INVOKE ShowEnemyImage, GameStatCursor

	; Fight loop
	sub GameStatCursor.X, EnemyInfoPositionX-UserInfoPositionX	;move cursor to UserInfoPosition
	mov esi, OFFSET User
	DelayForARound

	L1:  ; Assume user attack enemy 20, Enemy attack user 15
		mov ecx, 0
		INVOKE RunFightProcess, OFFSET User, OFFSET Enemy, GameStatCursor
		cmp eax, 1
		je Done
		jmp Dummy

		Done:
			; Restore user status after fight
			DelayForARound
			mov eax, 1000
			mov (CHARACTERATTRIBUTE PTR [esi]).Ingame.HP, eax
			mov eax, 100
			mov (CHARACTERATTRIBUTE PTR [esi]).Ingame.MP, eax
			mov eax, 100
			mov (CHARACTERATTRIBUTE PTR [esi]).Ingame.EP, eax
			mov ecx, 1
		Dummy:
			DelayForARound
	LOOP L1
	; Clear fight UI
	INVOKE EraseCharInfoGraph, OFFSET User, GameStatCursor
	INVOKE EraseAllyImage, GameStatCursor
	
	add GameStatCursor.X, EnemyInfoPositionX-UserInfoPositionX
	INVOKE EraseCharInfo, OFFSET Enemy, GameStatCursor
	INVOKE EraseCharInfoGraph, OFFSET Enemy, GameStatCursor
	INVOKE EraseEnemyImage, GameStatCursor
	ret 4

IntoFightStat endp

; ------------------------------------------------------------
; Handle Start Sub-State
; ------------------------------------------------------------
CheStartSubStat proc uses esi eax CurStat: PTR GAMESTAT, SubStat: BYTE

	mov esi, CurStat

	mov al, SubStat
	mov (GAMESTAT PTR [esi]).SubStat, al
	INVOKE clear_screen

	INVOKE InitBackPack, OFFSET GameBp
	INVOKE ShowBackpack, GameStatCursor
		
	ret

CheStartSubStat endp

; ------------------------------------------------------------
; Handle Prepare Sub-State (Buy / Pack)
; ------------------------------------------------------------
ChePrepareSubStat proc uses esi eax ecx ebx CurStat: PTR GAMESTAT, SubStat: BYTE
	
	mov esi, CurStat
	mov al, SubStat
	mov (GAMESTAT PTR [esi]).SubStat, al
	INVOKE ShowStage, CurStat

	xor ecx, ecx
	mov ecx, 3
	cmp al, BuyStat
	je L1
	
	cmp al, PackStat
	je L2	
; -------- Buy Process --------
	L1:                         ;Buy Process, break untile user done
		mov ecx, 0
		mov eax, 0
		call ReadChar
		cmp al, ShowInst
		je ShowProcess1
		cmp al, BuyInst
		je BuyProcess
		cmp al, EndInst
		je EndProcess1
		jmp Dummy1	

		EndProcess1: 
			mov ecx, 1
			jmp Dummy1		
		ShowProcess1:
			INVOKE ReadInt09
			INVOKE ShowToolInfo, OFFSET Seller, al
			jmp Dummy1
		BuyProcess:
			mov ax, UserInfoPositionX
			mov GameStatCursor.X, ax
			mov ax, UserInfoPositionY
			mov GameStatCursor.Y, ax

			INVOKE RunBuyProcess, OFFSET Seller, OFFSET OurGoods, OFFSET User, GameStatCursor, OFFSET GameStatToolBuf 
		Dummy1:
	LOOP L1

	jmp Done
	; -------- Pack Process --------
	L2:                          ;Pack Process, break untile user done
		mov ecx, 0
		mov eax, 0
		call ReadChar
		cmp al, ShowInst
		je ShowProcess2
		cmp al, PackInst
		je PackProcess
		cmp al, EndInst
		je EndProcess2
		jmp Dummy2	

		EndProcess2: 
			mov ecx, 1
			INVOKE ShowPackEraseGraph
			jmp Dummy2		
		ShowProcess2:
			INVOKE ReadInt09
			INVOKE ShowToolInfo, OFFSET OurGoods, al
			jmp Dummy2
		PackProcess:
			INVOKE RunPackProcess, OFFSET GameBp, OFFSET OurGoods, OFFSET GameStatToolBuf 
		Dummy2:
	LOOP L2

	Done:

	ret

ChePrepareSubStat endp

; ------------------------------------------------------------
; Handle Fight Sub-State
; ------------------------------------------------------------
CheFightSubStat proc uses esi eax CurStat: PTR GAMESTAT, SubStat: BYTE
	
	mov esi, CurStat
	mov al, SubStat
	mov (GAMESTAT PTR [esi]).SubStat, al
		
	ret 8

CheFightSubStat endp

end