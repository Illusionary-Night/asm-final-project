INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/MemOperation.inc
.data
	showed_slot_position COORD <>
	showed_shape_counter DWORD ?
	showed_slot_counter DWORD ?
.code

ExecuteTool PROC USES esi,
	Object: PTR TOOL

    mov esi, Object

    ret
ExecuteTool ENDP

CooldownUpdate_Tool PROC USES esi eax,
	Object: PTR TOOL

    mov esi, Object
    mov eax, (TOOL PTR [esi]).COOLDOWN
    add eax, 1
    cmp eax, (TOOL PTR [esi]).COOLDOWNMAX
    jb Label_end
    mov eax, 0
    INVOKE ExecuteTool, Object

Label_end:
    mov (TOOL PTR [esi]).COOLDOWN, eax
    ret
CooldownUpdate_Tool ENDP


ShowTool PROC USES esi edi eax ecx edx ebx, ;ebx edx不要拿來記憶 有坑 有人沒有USES
	Source : PTR TOOL
    
	mov esi, Source
	mov ecx, 0
	mov showed_slot_counter, 0
	mov showed_shape_counter, 0
	
	mov bx, (TOOL PTR [esi]).BPPOSITION.Y
	mov showed_slot_position.Y, bx

OuterLoop:
	mov eax, 0
	
	mov bx, (TOOL PTR [esi]).BPPOSITION.X
	mov showed_slot_position.X, bx


InnerLoop:
	
	lea edi, (TOOL PTR [esi]).SHAPE
	add edi, showed_shape_counter


	cmp BYTE PTR [edi], '1'
	jne DontShowSlot
	lea edi, (TOOL PTR [esi]).SLOT
	add edi, showed_slot_counter
	INVOKE ShowToolSlot, edi, showed_slot_position

DontShowSlot:	
	
	add showed_slot_counter, SIZEOF TOOLSLOT
	add showed_shape_counter, SIZEOF BYTE

	inc eax
	add WORD PTR showed_slot_position.X, 7


	cmp eax, 4
	jb InnerLoop
	
	inc ecx
	add WORD PTR showed_slot_position.Y, 7

	cmp ecx, 4
	jb OuterLoop

    ret
ShowTool ENDP


END