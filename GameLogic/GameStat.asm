INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/GameLogic/GameStat.inc
INCLUDE ./asm-final-project/GameLogic/GameClock.inc
INCLUDE ./asm-final-project/IO/display.inc

.data

.code

IntoPrepareStat proc uses esi eax CurStat: GAMESTAT

	mov esi, CurStat
	mov al, PrepareStat
	mov (GAMESTAT PTR [esi]).MainStat, al

	mov al, InstructionStat
	mov (GAMESTAT PTR [esi]).SubStat, al
	ret 4

IntoPrepareStat endp

IntoFightStat proc CurStat: GAMESTAT

	mov esi, CurStat
	mov al, FightStat
	mov (GAMESTAT PTR [esi]).MainStat, al

	mov al, SelfStat
	mov (GAMESTAT PTR [esi]).SubStat, al
	ret 4

IntoFightStat endp

CheStartSubStat proc CurStat: GAMESTAT SubStat: BYTE

	mov esi, CurStat

	mov al, SubStat
	mov (GAMESTAT PTR [esi]).SubStat, al
	INVOKE clear_screen
		
	ret 8

CheStartSubStat endp

ChePrepareSubStat proc CurStat: GAMESTAT, SubStat: BYTE
	
	mov esi, CurStat
	mov al, SubStat
	mov (GAMESTAT PTR [esi]).SubStat, al
		
	ret 8

ChePrepareSubStat endp

CheFightSubStat proc CurStat: GAMESTAT, SubStat: BYTE
	
	mov esi, CurStat
	mov al, SubStat
	mov (GAMESTAT PTR [esi]).SubStat, al
		
	ret 8

CheFightSubStat endp

end