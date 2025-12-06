.NOLIST

IFNDEF __GameProcess
__GameProcess EQU 1

UserAttributeX EQU 60
UserAttributeY EQU 0

SetGameProcessCursor macro NEWX, NEWY
	push eax

	mov ax, NEWX
	mov GameProcessCursor.X, ax

	mov ax, NEWY
	mov GameProcessCursor.Y, ax

	pop eax
endm

AddGameProcessCursorY macro num
	push eax
	
	mov ax, GameProcessCursor.Y
	add ax, num
	mov GameProcessCursor.Y, ax

	pop eax
endm

RunPackProcess PROTO,
	OurBp: PTR BACKPACK,
	Shelf: PTR GOODS,
	Target: PTR TOOL

RunBuyProcess PROTO,
	Shelf1: PTR GOODS,
	Shelf2: PTR GOODS,
	Char: PTR CHARACTERATTRIBUTE,
	Position: COORD

;return the fight result to eax, 0 not done, 1 done
RunFightProcess PROTO,                  ; Assume user attack enemy 20, Enemy attack user 15
	AllyChar: PTR CHARACTERATTRIBUTE,  ;User
	EnemyChar: PTR CHARACTERATTRIBUTE,	;Enemy
	Position: COORD

ProcessPeriodicTools PROTO,
	AllyChar: PTR CHARACTERATTRIBUTE, 
	EnemyChar: PTR CHARACTERATTRIBUTE
ENDIF