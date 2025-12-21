.NOLIST
IFNDEF _EndScene
_EndScene EQU 1

;------------------------------------------------------
; Set cursor position for end scene display
;------------------------------------------------------
SetEndSceneCursor macro NEWX, NEWY
	push eax

	mov ax, NEWX
	mov EndSceneCursor.X, ax

	mov ax, NEWY
	mov EndSceneCursor.Y, ax

	pop eax
endm

;------------------------------------------------------
; Show end game scene
;------------------------------------------------------
ShowEndGame PROTO

ENDIF