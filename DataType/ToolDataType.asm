INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/MemOperation.inc
.data
	showed_slot_position COORD <>
.code

ExecuteTool PROC USES esi,
	Object: PTR TOOL

    mov esi, Object
    ; �N����delta�ݩʥ[�쨤�⨭�W
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


ShowTool PROC USES esi edi eax ecx, 
    Source : PTR TOOL
    
	mov esi, Source
	mov ecx, 0
	
	mov dx, (TOOL PTR [esi]).BPPOSITION.Y
	mov showed_slot_position.Y, dx

OuterLoop:
	mov eax, 0
	
	mov dx, (TOOL PTR [esi]).BPPOSITION.X
	mov showed_slot_position.X, dx

InnerLoop:

    mov edi, ecx
    shl edi, 2      ; edi = ecx * 4
    add edi, eax
	cmp (TOOL PTR [esi]).SHAPE[edi], '1'
	jne DontShowSlot
	INVOKE ShowToolSlot, esi, showed_slot_position

DontShowSlot:	
	add esi, SIZEOF TOOLSLOT
	
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