.NOLIST

IFNDEF __GameClock
__GameClock EQU 1

; ------------------------------------------------------------
; Time configuration (in milliseconds)
; ------------------------------------------------------------
TimePerRound     EQU 1000   ;ms
TimePerSpeEffect EQU 50    ;ms

; ------------------------------------------------------------
; DelayXms
; Macro: Delay execution for X milliseconds
; Uses Irvine32 Delay procedure
; ------------------------------------------------------------
DelayXms macro X      ;Delay for Xms
	push eax
	mov eax, X
	call Delay
	pop eax 
endm

; ------------------------------------------------------------
; DelayForARound
; Macro: Delay for one full game round
; ------------------------------------------------------------
DelayForARound macro
	DelayXms TimePerRound
endm

; ------------------------------------------------------------
; DelayForSpeEffect
; Macro: Delay for special effect animation
; ------------------------------------------------------------
DelayForSpeEffect macro
	DelayXms TimePerSpeEffect 
endm

ENDIF