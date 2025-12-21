.NOLIST

IFNDEF __StageGraph
__StageGraph EQU 1

;------------------------------------------------------
; Stage dimensions and default color
;------------------------------------------------------
StagePositionX EQU 80
StagePositionY EQU 40

StageColor EQU  14

; Graph widths for different stages
BuyStageGraphWidth  EQU 103 
PackStageGraphWidth EQU 112
FightStageGraphWidth EQU 112

;------------------------------------------------------
; Macros to set or adjust stage cursor
;------------------------------------------------------
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

;------------------------------------------------------
; Procedures to show and erase stage graphics
;------------------------------------------------------
ShowStage PROTO,
	CurStat: PTR GAMESTAT

ShowStageGraph PROTO,
	Source: PTR TEXT,
	_Length: WORD



EraseStageGraph PROTO

                                                                                
                                                                            
ENDIF