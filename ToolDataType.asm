INCLUDE Irvine32.inc
INCLUDE graph.inc
INCLUDE GameDataType.inc
INCLUDE ToolDataType.inc
.data
	
.code
MemClone PROC USES esi edi ecx, Object:PTR BYTE, Source:PTR BYTE, _Length:DWORD
    mov esi, Source
    mov edi, Object
    mov ecx, _Length
    rep movsb
    ret
MemClone ENDP

SetProtoTool PROC USES esi edi eax,     ;用於設置道具種類，而非新增
	Object: PTR TOOL,
	Slot: PTR TOOLSLOT,	; 陣列起始座標，長度16 TOOLSLOT
	Shape: PTR BYTE,	; 陣列起始座標，長度16 BYTE
	Rarity: BYTE,
	CooldownMax: DWORD,
	TypeID: DWORD,

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
    
    ret
SetProtoTool ENDP

ExecuteTool PROC USES esi,
	Object: PTR TOOL

    mov esi, Object
    ; 將角色delta屬性加到角色身上
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