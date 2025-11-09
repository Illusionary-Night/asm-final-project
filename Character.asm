INCLUDE Irvine32.inc
INCLUDE Character.inc
INCLUDE MemOperation.inc
.data
	
.code
SetAttribute PROC USES esi edi eax,    
	Object: PTR ATTRIBUTE,
	HP: SDWORD,
	EP: SDWORD,
	MP: SDWORD,
	SHIELD: SDWORD,
	REGENERATION: SDWORD,
	BURN: SDWORD,
	THORNS: SDWORD

    mov esi, Object
    
    mov eax, HP
    mov (ATTRIBUTE PTR [esi]).HP, eax
    
    mov eax, EP
    mov (ATTRIBUTE PTR [esi]).EP, eax
    
    mov eax, MP
    mov (ATTRIBUTE PTR [esi]).MP, eax
    
    mov eax, SHIELD
    mov (ATTRIBUTE PTR [esi]).SHIELD, eax
    
    mov eax, REGENERATION
    mov (ATTRIBUTE PTR [esi]).REGENERATION, eax
    
    mov eax, BURN
    mov (ATTRIBUTE PTR [esi]).BURN, eax
    
    mov eax, THORNS
    mov (ATTRIBUTE PTR [esi]).THORNS, eax
    ret
SetAttribute ENDP

OverlayAttribute PROC USES esi edi eax,
    Object: PTR ATTRIBUTE,
    Source: PTR ATTRIBUTE

    mov esi, Object
    mov edi, Source

    mov eax, (ATTRIBUTE PTR [edi]).HP
    add eax, (ATTRIBUTE PTR [esi]).HP
    call TransformNegativeToZero
    mov (ATTRIBUTE PTR [esi]).HP, eax
    
    mov eax, (ATTRIBUTE PTR [edi]).EP
    add eax, (ATTRIBUTE PTR [esi]).EP
    call TransformNegativeToZero
    mov (ATTRIBUTE PTR [esi]).EP, eax

    mov eax, (ATTRIBUTE PTR [edi]).MP
    add eax, (ATTRIBUTE PTR [esi]).MP
    call TransformNegativeToZero
    mov (ATTRIBUTE PTR [esi]).MP, eax

    mov eax, (ATTRIBUTE PTR [edi]).SHIELD
    add eax, (ATTRIBUTE PTR [esi]).SHIELD
    call TransformNegativeToZero
    mov (ATTRIBUTE PTR [esi]).SHIELD, eax

    mov eax, (ATTRIBUTE PTR [edi]).REGENERATION
    add eax, (ATTRIBUTE PTR [esi]).REGENERATION
    call TransformNegativeToZero
    mov (ATTRIBUTE PTR [esi]).REGENERATION, eax

    mov eax, (ATTRIBUTE PTR [edi]).BURN
    add eax, (ATTRIBUTE PTR [esi]).BURN
    call TransformNegativeToZero
    mov (ATTRIBUTE PTR [esi]).BURN, eax

    mov eax, (ATTRIBUTE PTR [edi]).THORNS
    add eax, (ATTRIBUTE PTR [esi]).THORNS
    call TransformNegativeToZero
    mov (ATTRIBUTE PTR [esi]).THORNS, eax
 
    ret
OverlayAttribute ENDP

TransformNegativeToZero PROC        ;¤ñ¸ûeax¥¿­t
    cmp eax, 0
    jl Lab_Negative
    jmp Lab_PositiveOrZero

Lab_Negative:
    mov eax, 0
Lab_PositiveOrZero:
    ret
TransformNegativeToZero ENDP
END