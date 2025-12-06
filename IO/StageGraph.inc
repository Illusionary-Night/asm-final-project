.NOLIST

IFNDEF __StageGraph
__StageGraph EQU 1

StagePositionX EQU 80
StagePositionY EQU 40

StageColor EQU  14

BuyStageGraphWidth  EQU 103 
PackStageGraphWidth EQU 112
FightStageGraphWidth EQU 112


SetStageGraphCursor macro NEWX, NEWY
	push eax

	mov ax, NEWX
	mov StageGraphCursorBuf.X, ax

	mov ax, NEWY
	mov StageGraphCursorBuf.Y, ax

	pop eax
endm

AddStageGraphCursorY macro num
	push eax
	
	mov ax, StageGraphCursorBuf.Y
	add ax, num
	mov StageGraphCursorBuf.Y, ax

	pop eax
endm

ShowStage PROTO,
	CurStat: PTR GAMESTAT

ShowStageGraph PROTO,
	Source: PTR TEXT,
	_Length: WORD



EraseStageGraph PROTO

                                                                                
                                                                            
ENDIF