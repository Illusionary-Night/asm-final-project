INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/MemOperation.inc
.data
	showed_slot_position COORD <>
	showed_shape_counter DWORD ?
	showed_slot_counter DWORD ?
	Msg_Cooldown BYTE "     Cooldown Remain: ", 0
.code

; ---------------------------------------------------------
; CooldownUpdate_Tool
; Updates the tool's cooldown timer.
; Logic: Decrements COOLDOWN. 
; Returns EAX = 1 if Ready (0), EAX = 0 if Cooling down.
; Resets to COOLDOWNMAX immediately upon reaching 0.
; ---------------------------------------------------------
CooldownUpdate_Tool PROC USES esi ebx edx, ;return 1 if cooldown 0
	Object: PTR TOOL

	;mov edx, OFFSET Msg_Cooldown
	;call WriteString
	;push eax
	;mov eax, (TOOL PTR [esi]).COOLDOWN
	;call WriteDec
	;pop eax

    mov esi, Object

	cmp (TOOL PTR [esi]).COOLDOWN, 0
	je Label_CoolingCompleted
	
	dec (TOOL PTR [esi]).COOLDOWN
	
	jmp Label_Cooling

Label_CoolingCompleted:
	; Reset timer and return Success (1)
	mov ebx, (TOOL PTR [esi]).COOLDOWNMAX
	mov (TOOL PTR [esi]).COOLDOWN, ebx
	mov eax, 1
	jmp Label_end
Label_Cooling:
	; Still waiting, return Fail (0)
    mov eax, 0
Label_end:
    ret 4
CooldownUpdate_Tool ENDP	;uses eax to return

; ---------------------------------------------------------
; ShowTool
; Renders the tool onto the backpack grid.
; Iterates through the 4x4 SHAPE array.
; If SHAPE[i] == '1', draws the corresponding TOOLSLOT.
; ---------------------------------------------------------
ShowTool PROC USES esi edi eax ecx edx ebx, ;ebx edx���n���ӰO�� ���| ���H�S��USES
	Source : PTR TOOL
    
	mov esi, Source
	mov ecx, 0							; Outer Loop Counter (Y: 0-3)
	mov showed_slot_counter, 0			; Byte offset for SLOT array
	mov showed_shape_counter, 0			; Byte offset for SHAPE array
	
	; Set Base Y
	mov bx, (TOOL PTR [esi]).BPPOSITION.Y
	mov showed_slot_position.Y, bx

OuterLoop:
	mov eax, 0							; Inner Loop Counter (X: 0-3)
	
	; Reset Base X for new row
	mov bx, (TOOL PTR [esi]).BPPOSITION.X
	mov showed_slot_position.X, bx


InnerLoop:
	; Check Shape at current index
	lea edi, (TOOL PTR [esi]).SHAPE
	add edi, showed_shape_counter


	cmp BYTE PTR [edi], '1'
	jne DontShowSlot			; Skip if empty block

	; Draw valid block
	lea edi, (TOOL PTR [esi]).SLOT
	add edi, showed_slot_counter
	INVOKE ShowToolSlot, edi, showed_slot_position

DontShowSlot:	
	; Advance pointers and coords
	add showed_slot_counter, SIZEOF TOOLSLOT
	add showed_shape_counter, SIZEOF BYTE

	inc eax
	add WORD PTR showed_slot_position.X, 1


	cmp eax, 4
	jb InnerLoop
	
	; Next Row
	inc ecx
	add WORD PTR showed_slot_position.Y, 1

	cmp ecx, 4
	jb OuterLoop

    ret
ShowTool ENDP


END