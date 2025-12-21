.NOLIST

IFNDEF __GameProcess
__GameProcess EQU 1

; ------------------------------------------------------------
; UI position for user attribute display
; ------------------------------------------------------------
UserAttributeX EQU 60
UserAttributeY EQU 0

; ------------------------------------------------------------
; Set cursor position for game process UI
; ------------------------------------------------------------
SetGameProcessCursor macro NEWX, NEWY
	push eax

	mov ax, NEWX
	mov GameProcessCursor.X, ax

	mov ax, NEWY
	mov GameProcessCursor.Y, ax

	pop eax
endm

; ------------------------------------------------------------
; Move game process cursor down by 'num' lines
; ------------------------------------------------------------
AddGameProcessCursorY macro num
	push eax
	
	mov ax, GameProcessCursor.Y
	add ax, num						; Increase Y position
	mov GameProcessCursor.Y, ax

	pop eax
endm

; ------------------------------------------------------------
; Run backpack interaction process
; ------------------------------------------------------------
RunPackProcess PROTO,
	OurBp: PTR BACKPACK,
	Shelf: PTR GOODS,
	Target: PTR TOOL

; ------------------------------------------------------------
; Run buying process between shelves
; ------------------------------------------------------------
RunBuyProcess PROTO,
	Shelf1: PTR GOODS,
	Shelf2: PTR GOODS,
	Char: PTR CHARACTERATTRIBUTE,
	Position: COORD,
	Target: PTR TOOL

; ------------------------------------------------------------
; Run fight process
; Return value in EAX:
;   0 = not finished
;   1 = fight done
; ------------------------------------------------------------
;return the fight result to eax, 0 not done, 1 done
RunFightProcess PROTO,                  ; Assume user attack enemy 20, Enemy attack user 15
	AllyChar: PTR CHARACTERATTRIBUTE,  ;User
	EnemyChar: PTR CHARACTERATTRIBUTE,	;Enemy
	Position: COORD

; ------------------------------------------------------------
; Apply periodic tool effects during fight
; ------------------------------------------------------------
ProcessPeriodicTools PROTO,
	AllyChar: PTR CHARACTERATTRIBUTE, 
	EnemyChar: PTR CHARACTERATTRIBUTE
ENDIF