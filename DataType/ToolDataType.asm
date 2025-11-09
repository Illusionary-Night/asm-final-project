INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
.data
	
.code

SetProtoTool PROC USES esi edi eax,     ;�Ω�]�m�D������A�ӫD�s�W
	Object: PTR TOOL,
	Slot: PTR TOOLSLOT,	; �}�C�_�l�y�СA����16 TOOLSLOT
	Shape: PTR BYTE,	; �}�C�_�l�y�СA����16 BYTE
	Rarity: BYTE,
	CooldownMax: DWORD,
	TypeID: DWORD,
    AllyDelta: ATTRIBUTE,
    EnemyDelta: ATTRIBUTE

    mov esi, Object
    
    lea edi, (TOOL PTR [esi]).SLOT
    INVOKE MemClone, edi, Slot, SIZEOF TOOLSLOT * 16
    
    lea edi, (TOOL PTR [esi]).SHAPE
    INVOKE MemClone, edi, Shape, SIZEOF BYTE * 16
    
    mov al, Rarity
    mov (TOOL PTR [esi]).RARITY, al
    
    mov eax, CooldownMax
    mov (TOOL PTR [esi]).COOLDOWNMAX, eax
    
    mov eax, TypeID
    mov (TOOL PTR [esi]).TYPEID, eax
    
    lea edi, (TOOL PTR [esi]).ALLYDELTA
    INVOKE MemClone, edi, ADDR AllyDelta, SIZEOF ATTRIBUTE

    lea edi, (TOOL PTR [esi]).ENEMYDELTA
    INVOKE MemClone, edi, ADDR EnemyDelta, SIZEOF ATTRIBUTE

    ret
SetProtoTool ENDP

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



END