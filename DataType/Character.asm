INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/DataType/Character.inc
INCLUDE ./asm-final-project/MemOperation.inc
.data
	
.code
SetInGameAttribute PROC USES esi,
    pAttr:PTR INGAMEATTRIBUTE,
    hp:SDWORD, ep:SDWORD, mp:SDWORD

    mov esi, pAttr

    mov eax, hp
    mov (INGAMEATTRIBUTE PTR [esi]).HP, eax

    mov eax, ep
    mov (INGAMEATTRIBUTE PTR [esi]).EP, eax

    mov eax, mp
    mov (INGAMEATTRIBUTE PTR [esi]).MP, eax

    ret
SetInGameAttribute ENDP

InitializeInGameAttribute PROC USES esi eax,
    pChar:PTR CHARACTERATTRIBUTE

    mov esi, pChar
    ; ���o Resource ���̤j��
    mov eax, (CHARACTERATTRIBUTE PTR [esi]).Resource.MAXHP
    mov ebx, (CHARACTERATTRIBUTE PTR [esi]).Resource.MAXEP
    mov ecx, (CHARACTERATTRIBUTE PTR [esi]).Resource.MAXMP

    ; �I�s SetInGameAttribute
    INVOKE SetInGameAttribute, esi, eax, ebx, ecx

    ret
InitializeInGameAttribute ENDP

CheckInGameStatEnough PROC USES esi edi eax,
    pAttr:PTR INGAMEATTRIBUTE,
    pFieldOffset:PTR SDWORD,
    needVal:SDWORD

    mov esi, pAttr
    mov edi, pFieldOffset

    mov eax, [esi + edi]   ; Ū����
    cmp eax, needVal
    jl notEnough

    mov eax, 1
    ret

notEnough:
    mov eax, 0
    ret

CheckInGameStatEnough ENDP

OverlayInGameAttribute PROC USES esi edi ebx ecx edx,   ; RETURN flag in eax 1= fail 0= success
    pAttr1:PTR CHARACTERATTRIBUTE,
    pAttr2:PTR INGAMEATTRIBUTE,
    TypeFlag:DWORD            ; 0 = Demand, 1 = Effect

    mov esi, pAttr1
    lea edx, (CHARACTERATTRIBUTE PTR [esi]).Resource
    mov edi, pAttr2
    xor eax, eax              ; flag = 0

    ; ---------------------------
    ; �����p�� HP
    mov ebx, (INGAMEATTRIBUTE PTR [edi]).HP
    mov ecx, (INGAMEATTRIBUTE PTR [esi]).HP
    add ecx, ebx
    cmp TypeFlag, 0
    je checkDemandHP
checkEffectHP:
    ; �ĪG�Ҧ��A�t���k�s
    cmp ecx, 0
    jge okHP
    mov (INGAMEATTRIBUTE PTR [esi]).HP, 0
    mov eax, 1
    jmp nextHP
okHP:
    mov (INGAMEATTRIBUTE PTR [esi]).HP, ecx
nextHP:
    ; ---------------------------
    ; �����p�� EP
    mov ebx, (INGAMEATTRIBUTE PTR [edi]).EP
    mov ecx, (INGAMEATTRIBUTE PTR [esi]).EP
    add ecx, ebx
    cmp TypeFlag, 0
    je checkDemandEP
checkEffectEP:
    cmp ecx, 0
    jge okEP
    mov (INGAMEATTRIBUTE PTR [esi]).EP, 0
    mov eax, 1
    jmp nextEP
okEP:
    mov (INGAMEATTRIBUTE PTR [esi]).EP, ecx
nextEP:
    ; ---------------------------
    ; �����p�� MP
    mov ebx, (INGAMEATTRIBUTE PTR [edi]).MP
    mov ecx, (INGAMEATTRIBUTE PTR [esi]).MP
    add ecx, ebx
    cmp TypeFlag, 0
    je checkDemandMP
checkEffectMP:
    cmp ecx, 0
    jge okMP
    mov (INGAMEATTRIBUTE PTR [esi]).MP, 0
    mov eax, 1
    jmp nextMP
okMP:
    mov (INGAMEATTRIBUTE PTR [esi]).MP, ecx
nextMP:
    cmp TypeFlag, 0
    je demandCheckDone
    ret

; ---------------------------
; �ݨD�Ҧ��ˬd
checkDemandHP:
    cmp ecx, 0
    jl failOverlay
    jmp nextHP
checkDemandEP:
    cmp ecx, 0
    jl failOverlay
    jmp nextEP
checkDemandMP:
    cmp ecx, 0
    jl failOverlay
    jmp nextMP
demandCheckDone:
    ; �����ˬd�q�L �� �|�[

    mov ebx, (INGAMEATTRIBUTE PTR [esi]).HP ;player's current HP
    add ebx, (INGAMEATTRIBUTE PTR [edi]).HP ;tool effect
    cmp ebx, (RESOURCEATTRIBUTE PTR [edx]).MAXHP    ;check if changed HP exceed maxHP
    jle validHP
    mov ebx, (RESOURCEATTRIBUTE PTR [edx]).MAXHP    ;make sure that current HP <= maxHP
validHP:
    mov (INGAMEATTRIBUTE PTR [esi]).HP, ebx
    
    mov ebx, (INGAMEATTRIBUTE PTR [esi]).EP
    add ebx, (INGAMEATTRIBUTE PTR [edi]).EP
    cmp ebx, (RESOURCEATTRIBUTE PTR [edx]).MAXEP
    jle validEP
    mov ebx, (RESOURCEATTRIBUTE PTR [edx]).MAXEP
validEP:
    mov (INGAMEATTRIBUTE PTR [esi]).EP, ebx

    mov ebx, (INGAMEATTRIBUTE PTR [esi]).MP
    add ebx, (INGAMEATTRIBUTE PTR [edi]).MP
    cmp ebx, (RESOURCEATTRIBUTE PTR [edx]).MAXMP
    jle validMP
    mov ebx, (RESOURCEATTRIBUTE PTR [edx]).MAXMP
validMP:
    mov (INGAMEATTRIBUTE PTR [esi]).MP, ebx

    mov eax, 0
    ret

failOverlay:
    mov eax, 1
    ret

OverlayInGameAttribute ENDP


SetResourceAttribute PROC USES esi,
    pAttr:PTR RESOURCEATTRIBUTE,
    maxhp:SDWORD, maxep:SDWORD, maxmp:SDWORD,
    money:SDWORD, lives:SDWORD

    mov esi, pAttr

    mov eax, maxhp
    mov (RESOURCEATTRIBUTE PTR [esi]).MAXHP, eax

    mov eax, maxep
    mov (RESOURCEATTRIBUTE PTR [esi]).MAXEP, eax

    mov eax, maxmp
    mov (RESOURCEATTRIBUTE PTR [esi]).MAXMP, eax

    mov eax, money
    mov (RESOURCEATTRIBUTE PTR [esi]).MONEY, eax

    mov eax, lives
    mov (RESOURCEATTRIBUTE PTR [esi]).LIVES, eax

    ret
SetResourceAttribute ENDP

InitializeResourceAttribute PROC USES esi,
    pAttr:PTR RESOURCEATTRIBUTE

    mov esi, pAttr

    ; �����I�s SetResourceAttribute ������M�� 0
    INVOKE SetResourceAttribute, esi, 1000, 100, 100, 100, 5    ; �Ѽ�: maxhp, maxep, maxmp, money, lives

    ret
InitializeResourceAttribute ENDP


CheckMoneyEnough PROC USES esi,
    pChar:PTR CHARACTERATTRIBUTE,
    needMoney:SDWORD

    mov esi, pChar
    mov eax, (CHARACTERATTRIBUTE PTR [esi]).Resource.MONEY
    cmp eax, needMoney
    jl notEnough

    mov eax, 1
    ret

notEnough:
    mov eax, 0
    ret

CheckMoneyEnough ENDP

CheckCharacterAlive PROC USES esi,
    pChar:PTR CHARACTERATTRIBUTE

    mov esi, pChar
    mov eax, (CHARACTERATTRIBUTE PTR [esi]).Resource.LIVES
    cmp eax, 0
    jg alive

    mov eax, 0
    ret

alive:
    mov eax, 1
    ret

CheckCharacterAlive ENDP


END