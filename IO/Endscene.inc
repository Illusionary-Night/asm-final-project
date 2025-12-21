.NOLIST
IFNDEF _EndScene
_EndScene EQU 1

SetEndSceneCursor macro NEWX, NEWY
	push eax

	mov ax, NEWX
	mov EndSceneCursor.X, ax

	mov ax, NEWY
	mov EndSceneCursor.Y, ax

	pop eax
endm

ShowEndGame PROTO

ENDIF