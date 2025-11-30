INCLUDE ./asm-final-project/SysInc/Irvine32.inc

INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/DataType/Seller.inc
INCLUDE ./asm-final-project/DataType/BackPack.inc

INCLUDE ./asm-final-project/IO/input.inc

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

GameMainLoop proc uses eax ecx ebx esi

	INVOKE IntoStartStat, OFFSET CurGameStat

	L2:
		
		TestKeyPress VK_SPACE
		jnz L4
		L3: 
			mov ecx, 0
			jmp Done
		L4: mov ecx, 1
		Done:
	loop L2

	INVOKE CheStartSubStat, OFFSET CurGameStat, GameRuleStat

	INVOKE SetTestTool	             ;we will initialize tool database here
	INVOKE CreateTool, OFFSET Game_UUID, 1
	

	L1:
		INVOKE IntoPrepareStat, OFFSET CurGameStat

		INVOKE ChePrepareSubStat, OFFSET CurGameStat, BuyStat
		INVOKE ChePrepareSubStat, OFFSET CurGameStat, PackStat
		
		INVOKE IntoFightStat, OFFSET CurGameStat
		mov ecx, 0
	LOOP L1

GameMainLoop endp

end
	