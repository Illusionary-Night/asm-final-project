.NOLIST

;we have 3 MainStat currently
;	0, Start						
;	1, Prepare
;	2, Fight
						
;Start have 2 SubStat
;	0, Start
;	1, GameRule
;Prepare have 3 SubStat
;	0, Instruction
;	1, Buy
;	2, Pack!
;Fight have 2 SubStat
;	0, Self
;	1, Enemy

IFNDEF __GameLogic
__GameLogic EQU 1

StartStat       EQU 0
PrepareStat     EQU 1
FightStat       EQU 2

StartSceneStat  EQU 0
GameRuleStat    EQU 1

InstructionStat EQU 0
BuyStat 	EQU 1
PackStat        EQU 2

SelfStat        EQU 0
EnemeStat       EQU 1

GAMESTAT STRUCT
	MainStat BYTE ?
	SubStat  BYTE ?
GAMESTAT ENDS

IntoPrepareStat PROTO,
	CurStat: PTR GAMESTAT

IntoFightStat PROTO,
	CurStat: PTR GAMESTAT

CheStartSubStat PROTO,
	CurStat: PTR GAMESTAT,
	SubStat: BYTE

ChePrepareSubStat PROTO,
	CurStat: PTR GAMESTAT,
	SubStat: BYTE

CheFightSubStat PROTO,
	CurStat: PTR GAMESTAT,
	SubStat: BYTE

ENDIF