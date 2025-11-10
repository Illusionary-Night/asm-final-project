INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/DataType/Character.inc
INCLUDE ./asm-final-project/MemOperation.inc
.data
	
.code
SetCharacterAttribute PROC USES esi edi eax,    
	Object: PTR CHARACTERATTRIBUTE,
	HP: SDWORD,
	EP: SDWORD,
	MP: SDWORD,
	SHIELD: SDWORD,
	REGENERATION: SDWORD,
	BURN: SDWORD,
	THORNS: SDWORD

    mov esi, Object
    
    mov eax, HP
    mov (CHARACTERATTRIBUTE PTR [esi]).HP, eax
    
    mov eax, EP
    mov (CHARACTERATTRIBUTE PTR [esi]).EP, eax
    
    mov eax, MP
    mov (CHARACTERATTRIBUTE PTR [esi]).MP, eax
    
    mov eax, SHIELD
    mov (CHARACTERATTRIBUTE PTR [esi]).SHIELD, eax
    
    mov eax, REGENERATION
    mov (CHARACTERATTRIBUTE PTR [esi]).REGENERATION, eax
    
    mov eax, BURN
    mov (CHARACTERATTRIBUTE PTR [esi]).BURN, eax
    
    mov eax, THORNS
    mov (CHARACTERATTRIBUTE PTR [esi]).THORNS, eax
    ret
SetCharacterAttribute ENDP

OverlayAttribute PROC USES esi edi eax,
    Object: PTR CHARACTERATTRIBUTE,
    Source: PTR CHARACTERATTRIBUTE

    mov esi, Object
    mov edi, Source

    mov eax, (CHARACTERATTRIBUTE PTR [edi]).HP
    add eax, (CHARACTERATTRIBUTE PTR [esi]).HP
    call TransformNegativeToZero
    mov (CHARACTERATTRIBUTE PTR [esi]).HP, eax
    
    mov eax, (CHARACTERATTRIBUTE PTR [edi]).EP
    add eax, (CHARACTERATTRIBUTE PTR [esi]).EP
    call TransformNegativeToZero
    mov (CHARACTERATTRIBUTE PTR [esi]).EP, eax

    mov eax, (CHARACTERATTRIBUTE PTR [edi]).MP
    add eax, (CHARACTERATTRIBUTE PTR [esi]).MP
    call TransformNegativeToZero
    mov (CHARACTERATTRIBUTE PTR [esi]).MP, eax

    mov eax, (CHARACTERATTRIBUTE PTR [edi]).SHIELD
    add eax, (CHARACTERATTRIBUTE PTR [esi]).SHIELD
    call TransformNegativeToZero
    mov (CHARACTERATTRIBUTE PTR [esi]).SHIELD, eax

    mov eax, (CHARACTERATTRIBUTE PTR [edi]).REGENERATION
    add eax, (CHARACTERATTRIBUTE PTR [esi]).REGENERATION
    call TransformNegativeToZero
    mov (CHARACTERATTRIBUTE PTR [esi]).REGENERATION, eax

    mov eax, (CHARACTERATTRIBUTE PTR [edi]).BURN
    add eax, (CHARACTERATTRIBUTE PTR [esi]).BURN
    call TransformNegativeToZero
    mov (CHARACTERATTRIBUTE PTR [esi]).BURN, eax

    mov eax, (CHARACTERATTRIBUTE PTR [edi]).THORNS
    add eax, (CHARACTERATTRIBUTE PTR [esi]).THORNS
    call TransformNegativeToZero
    mov (CHARACTERATTRIBUTE PTR [esi]).THORNS, eax
 
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