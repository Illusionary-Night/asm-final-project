INCLUDE ./asm-final-project/SysInc/Irvine32.inc

INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/DataType/Seller.inc
INCLUDE ./asm-final-project/DataType/BackPack.inc
INCLUDE ./asm-final-project/DataType/Character.inc

INCLUDE ./asm-final-project/IO/input.inc
INCLUDE ./asm-final-project/IO/display.inc
INCLUDE ./asm-final-project/IO/EndScene.inc

INCLUDE ./asm-final-project/ToolInfo.inc

INCLUDE ./asm-final-project/GameLogic/GameStat.inc
INCLUDE ./asm-final-project/GameLogic/GameClock.inc
INCLUDE ./asm-final-project/GameLogic/GameControler.inc
INCLUDE ./asm-final-project/GameLogic/GameProcess.inc

INCLUDE ./asm-final-project/ToolInfo.inc

.data
	CurGameStat GAMESTAT <>
	Game_UUID DWORD ?
.code

; ------------------------------------------------------------
; GameMainLoop
; Main loop controlling overall game flow
; ------------------------------------------------------------
GameMainLoop proc uses eax ecx ebx esi

	INVOKE IntoStartStat, OFFSET CurGameStat

	L2:
		
		TestKeyPress VK_SPACE		; Check if SPACE key is pressed
		jnz L4
		L3: 
			mov ecx, 0
			jmp Done
		L4: mov ecx, 1
		Done:
	loop L2							; Wait until condition is met

	INVOKE CheStartSubStat, OFFSET CurGameStat, GameRuleStat

	INVOKE SetTestTool	             ;we will initialize tool database here
	INVOKE SetAllTool				; initialize all tool info
	;INVOKE CreateTool, OFFSET Game_UUID, 1	

	L1:
		INVOKE IntoPrepareStat, OFFSET CurGameStat					; Enter prepare state

		INVOKE ChePrepareSubStat, OFFSET CurGameStat, BuyStat		; Check buy phase
		INVOKE ChePrepareSubStat, OFFSET CurGameStat, PackStat		; Check backpack phase
		
		INVOKE IntoFightStat, OFFSET CurGameStat
		cmp eax, 0
		jz EndGame
	jmp L1

	EndGame:
		INVOKE clear_screen
		INVOKE ShowEndGame
GameMainLoop endp

end
	