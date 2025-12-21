INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/IO/StageGraph.inc

INCLUDE ./asm-final-project/GameLogic/GameStat.inc


.data
	;-----------------------------
	; Stage text buffers for display
	;-----------------------------
	StageGraphTextBuf  TEXT <>
	BuyStageGraph1 Byte " ______                                _______           _______   _________ _______  _______  _       "
        BuyStageGraph2 Byte "(  ___ \ |\     /||\     /|  |\     /|(  ___  )|\     /|(  ____ )  \__   __/(  ___  )(  ___  )( \      "
        BuyStageGraph3 Byte "| (   ) )| )   ( |( \   / )  ( \   / )| (   ) || )   ( || (    )|     ) (   | (   ) || (   ) || (      "
        BuyStageGraph4 Byte "| (__/ / | |   | | \ (_) /    \ (_) / | |   | || |   | || (____)|     | |   | |   | || |   | || |      "
        BuyStageGraph5 Byte "|  __ (  | |   | |  \   /      \   /  | |   | || |   | ||     __)     | |   | |   | || |   | || |      "
        BuyStageGraph6 Byte "| (  \ \ | |   | |   ) (        ) (   | |   | || |   | || (\ (        | |   | |   | || |   | || |      "
        BuyStageGraph7 Byte "| )___) )| (___) |   | |        | |   | (___) || (___) || ) \ \__     | |   | (___) || (___) || (____/\"
        BuyStageGraph8 Byte "|/ \___/ (_______)   \_/        \_/   (_______)(_______)|/   \__/     )_(   (_______)(_______)(_______/"

	PackStageGraph1 Byte " _______  _______  _______  _                   _______           _______   _________ _______  _______  _       "
	PackStageGraph2 Byte "(  ____ )(  ___  )(  ____ \| \    /\  |\     /|(  ___  )|\     /|(  ____ )  \__   __/(  ___  )(  ___  )( \      "
	PackStageGraph3 Byte "| (    )|| (   ) || (    \/|  \  / /  ( \   / )| (   ) || )   ( || (    )|     ) (   | (   ) || (   ) || (      "
	PackStageGraph4 Byte "| (____)|| (___) || |      |  (_/ /    \ (_) / | |   | || |   | || (____)|     | |   | |   | || |   | || |      "
	PackStageGraph5 Byte "|  _____)|  ___  || |      |   _ (      \   /  | |   | || |   | ||     __)     | |   | |   | || |   | || |      "
	PackStageGraph6 Byte "| (      | (   ) || |      |  ( \ \      ) (   | |   | || |   | || (\ (        | |   | |   | || |   | || |      "
	PackStageGraph7 Byte "| )      | )   ( || (____/\|  /  \ \     | |   | (___) || (___) || ) \ \__     | |   | (___) || (___) || (____/\"
	PackStageGraph8 Byte "|/       |/     \|(_______/|_/    \/     \_/   (_______)(_______)|/   \__/     )_(   (_______)(_______)(_______/"

	FightStageGraph1 Byte " _______ _________ _______          _________   _______  _______  _______    _       _________ _______  _______ "
	FightStageGraph2 Byte "(  ____ \\__   __/(  ____ \|\     /|\__   __/  (  ____ \(  ___  )(  ____ )  ( \      \__   __/(  ____ \(  ____ \"
	FightStageGraph3 Byte "| (    \/   ) (   | (    \/| )   ( |   ) (     | (    \/| (   ) || (    )|  | (         ) (   | (    \/| (    \/"
	FightStageGraph4 Byte "| (__       | |   | |      | (___) |   | |     | (__    | |   | || (____)|  | |         | |   | (__    | (__    "
	FightStageGraph5 Byte "|  __)      | |   | | ____ |  ___  |   | |     |  __)   | |   | ||     __)  | |         | |   |  __)   |  __)   "
	FightStageGraph6 Byte "| (         | |   | | \_  )| (   ) |   | |     | (      | |   | || (\ (     | |         | |   | (      | (      "
	FightStageGraph7 Byte "| )      ___) (___| (___) || )   ( |   | |     | )      | (___) || ) \ \__  | (____/\___) (___| )      | (____/\"
	FightStageGraph8 Byte "|/       \_______/(_______)|/     \|   )_(     |/       (_______)|/   \__/  (_______/\_______/|/       (_______/"
                                                                                                                
                                                                                                                      
                                                                                                                

	StageGraphCursorBuf COORD <StagePositionX,StagePositionY>
.code

;-------------------------------------------------------------
; ShowStage: display stage based on current game status
;-------------------------------------------------------------
ShowStage proc uses esi eax ecx	CurStat: PTR GAMESTAT

	mov esi, CurStat
	INVOKE EraseStageGraph
	mov al, (GAMESTAT PTR [esi]).MainStat
	cmp al, PrepareStat

	je PerpareStage
	jmp FightStage

	PerpareStage:
		mov al,(GAMESTAT PTR [esi]).SubStat
		cmp al, BuyStat
		je BuyStage
		jmp PackStage

		BuyStage:
			INVOKE ShowStageGraph, OFFSET BuyStageGraph1, BuyStageGraphWidth
			jmp Done
		PackStage:
			INVOKE ShowStageGraph, OFFSET PackStageGraph1, PackStageGraphWidth
		jmp Done
	FightStage:
		INVOKE ShowStageGraph, OFFSET FightStageGraph1, FightStageGraphWidth
	Done:
	ret

ShowStage endp


;-------------------------------------------------------------
; ShowStageGraph: display 8 lines of ASCII stage
;-------------------------------------------------------------
ShowStageGraph proc uses esi eax Source: PTR TEXT, _Length: WORD

	mov esi, Source
	xor eax, eax
	SetStageGraphCursor StagePositionX, StagePositionY
	INVOKE SetText, OFFSET StageGraphTextBuf, esi, StageColor, StageGraphCursorBuf,  _Length
	INVOKE ShowText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1
	movzx eax, _Length
	add esi, eax

	INVOKE SetText, OFFSET StageGraphTextBuf, esi, StageColor, StageGraphCursorBuf,  _Length
	INVOKE ShowText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1
	movzx eax, _Length
	add esi, eax

	
	INVOKE SetText, OFFSET StageGraphTextBuf, esi, StageColor, StageGraphCursorBuf,  _Length
	INVOKE ShowText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1
	movzx eax, _Length
	add esi, eax

	
	INVOKE SetText, OFFSET StageGraphTextBuf, esi, StageColor, StageGraphCursorBuf,  _Length
	INVOKE ShowText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1
	movzx eax, _Length
	add esi, eax

	
	INVOKE SetText, OFFSET StageGraphTextBuf, esi, StageColor, StageGraphCursorBuf,  _Length
	INVOKE ShowText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1
	movzx eax, _Length
	add esi, eax


	INVOKE SetText, OFFSET StageGraphTextBuf, esi, StageColor, StageGraphCursorBuf,  _Length
	INVOKE ShowText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1
	movzx eax, _Length
	add esi, eax

	
	INVOKE SetText, OFFSET StageGraphTextBuf, esi, StageColor, StageGraphCursorBuf,  _Length
	INVOKE ShowText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1
	movzx eax, _Length
	add esi, eax


	INVOKE SetText, OFFSET StageGraphTextBuf, esi, StageColor, StageGraphCursorBuf,  _Length
	INVOKE ShowText, OFFSET StageGraphTextBuf
	
	ret

ShowStageGraph endp

;-------------------------------------------------------------
; EraseStageGraph: clear stage ASCII
;-------------------------------------------------------------
EraseStageGraph proc

	SetStageGraphCursor StagePositionX, StagePositionY
	INVOKE SetText, OFFSET StageGraphTextBuf, OFFSET BuyStageGraph1, StageColor, StageGraphCursorBuf, PackStageGraphWidth

	INVOKE EraseText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1

	INVOKE SetText, OFFSET StageGraphTextBuf, OFFSET BuyStageGraph2, StageColor, StageGraphCursorBuf, PackStageGraphWidth
	INVOKE EraseText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1
	
	INVOKE SetText, OFFSET StageGraphTextBuf, OFFSET BuyStageGraph3, StageColor, StageGraphCursorBuf, PackStageGraphWidth
	INVOKE EraseText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1
	
	INVOKE SetText, OFFSET StageGraphTextBuf, OFFSET BuyStageGraph4, StageColor, StageGraphCursorBuf, PackStageGraphWidth
	INVOKE EraseText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1
	
	INVOKE SetText, OFFSET StageGraphTextBuf, OFFSET BuyStageGraph5, StageColor, StageGraphCursorBuf, PackStageGraphWidth
	INVOKE EraseText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1

	INVOKE SetText, OFFSET StageGraphTextBuf, OFFSET BuyStageGraph6, StageColor, StageGraphCursorBuf, PackStageGraphWidth
	INVOKE EraseText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1
	
	INVOKE SetText, OFFSET StageGraphTextBuf, OFFSET BuyStageGraph7, StageColor, StageGraphCursorBuf, PackStageGraphWidth
	INVOKE EraseText, OFFSET StageGraphTextBuf
	AddStageGraphCursorY 1

	INVOKE SetText, OFFSET StageGraphTextBuf, OFFSET BuyStageGraph8, StageColor, StageGraphCursorBuf, PackStageGraphWidth
	INVOKE EraseText, OFFSET StageGraphTextBuf
	
	ret

EraseStageGraph endp

end