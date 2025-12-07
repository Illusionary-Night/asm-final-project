.NOLIST
IFNDEF __FightScene
__FightScene EQU 1

textGraphXGap EQU 14	;the gap between text and HP,SP,MP bar
upGraphYGap EQU 3 	;the gap between the upper bound screen boundary and HP,SP,MP bar
textYGap EQU 7		;the gap beteeen text
GraphYGap EQU textYGap + 1		;thhe gap between graph
imageYGap EQU upGraphYGap + 3 * textYGap

SetGameProcessCursor macro NEWX, NEWY
	push eax

	mov ax, NEWX
	mov GameProcessCursor.X, ax

	mov ax, NEWY
	mov GameProcessCursor.Y, ax

	pop eax
endm

ShowCharInfo PROTO,
	Char: PTR CHARACTERATTRIBUTE,
	Position: COORD

EraseCharInfo PROTO,
	Char: PTR CHARACTERATTRIBUTE,
	Position: COORD

ShowCharInfoGraph PROTO,
	Char: PTR CHARACTERATTRIBUTE,
	Position: COORD

EraseCharInfoGraph PROTO,
	Char: PTR CHARACTERATTRIBUTE,
	Position: COORD

ShowAllyImage PROTO Position: COORD

EraseAllyImage PROTO Position: COORD

ENDIF