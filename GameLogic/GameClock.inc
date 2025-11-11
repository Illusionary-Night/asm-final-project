.NOLIST

IFNDEF __GameClock
__GameClock EQU 1

TimePerRound     EQU 500   ;ms
TimePerSpeEffect EQU 50    ;ms

DelayXms macro X      ;Delay for Xms
	push eax
	mov eax, X
	call Delay
	pop eax 
endm

DelayForARound macro
	DelayXms TimePerRound
endm

DelayForSpeEffect macro
	DelayXms TimePerSpeEffect 
endm

ENDIF