.NOLIST

; ------------------------------------------------------------
; Game state definition
; ------------------------------------------------------------
;we have 3 MainStat currently
;	0, Start						
;	1, Prepare
;	2, Fight
						
;Start have 2 SubStat
;	0, Start
;	1, GameRule
;Prepare have 3 SubStat
;	0, Buy
;	2, Pack!
;Fight have 2 SubStat
;	0, Self
;	1, Enemy

IFNDEF __GameLogic
__GameLogic EQU 1

; -------------------------
; Main game states
; -------------------------
StartStat       EQU 0
PrepareStat     EQU 1	
FightStat       EQU 2

; -------------------------
; Start sub-states
; -------------------------
StartSceneStat  EQU 0
GameRuleStat    EQU 1

; -------------------------
; Prepare sub-states
; -------------------------
BuyStat 	EQU 0
PackStat        EQU 1

; -------------------------
; Fight sub-states
; -------------------------
SelfStat        EQU 0
EnemeStat       EQU 1

; -------------------------
; UI positions
; -------------------------
UserInfoPositionX EQU 60
UserInfoPositionY EQU 0

EnemyInfoPositionX EQU 130
EnemyInfoPositionY EQU 0

GameStagePositionX EQU 80
GameStagePositionY EQU 100

; -------------------------
; Game state structure
; -------------------------
GAMESTAT STRUCT
	MainStat BYTE ?
	SubStat  BYTE ?
GAMESTAT ENDS

; -------------------------
; State transition functions
; -------------------------
IntoStartStat PROTO,
	CurStat: PTR GAMESTAT

IntoPrepareStat PROTO,
	CurStat: PTR GAMESTAT

IntoFightStat PROTO,
	CurStat: PTR GAMESTAT

; -------------------------
; Sub-state checking functions
; -------------------------
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