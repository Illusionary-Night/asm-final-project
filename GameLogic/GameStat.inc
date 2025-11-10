.NOLIST

;we have 3 MainStat currently
;	0, Start						
;	1, Prepare
;	2, Fight
						
;Start don't have Substat
;Prepare have three SubStat
;	0, Instruction
;	1, Buy
;	2, Pack!
;Fight have two SubStat
;	0, Self
;	1, Enemy


GAMESTAT STRUCT
	MainStat BYTE ?
	SubStat  BYTE ?
GAMESTAT ENDS

IntoPrepareStat PROTO,
	CurStat: GAMESTAT

IntoFightStat PROTO,
	CurStat: GAMESTAT

ChePrepareSubStat PROTO,
	CurStat: GAMESTAT,
	SubStat: BYTE

CheFightSubStat PROTO,
	CurStat: GAMESTAT,
	SubStat: BYTE