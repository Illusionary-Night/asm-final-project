INCLUDE ./asm-final-project/SysInc/Irvine32.inc

INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/DataType/Seller.inc
INCLUDE ./asm-final-project/DataType/BackPack.inc
INCLUDE ./asm-final-project/ToolInfo.inc

INCLUDE ./asm-final-project/GameLogic/GameStat.inc
INCLUDE ./asm-final-project/GameLogic/GameClock.inc
INCLUDE ./asm-final-project/GameLogic/GameControler.inc

.data
	CurGameStat GAMESTAT <>
.code

GameMainLoop proc uses eax ecx ebx esi

	INVOKE IntoStartStat, OFFSET CurGameStat
	DelayXms 1000
	INVOKE CheStartSubStat, OFFSET CurGameStat, GameRuleStat
	
	;L1:
		INVOKE IntoPrepareStat, OFFSET CurGameStat

		INVOKE ChePrepareSubStat, OFFSET CurGameStat, BuyStat
		;INVOKE ChePrepareSubStat, OFFSET CurGameStat, PackStat
		
		;INVOKE IntoFightStat, OFFSET CurGameStat
		mov ecx, 0
	;LOOP L1

GameMainLoop endp

end
	