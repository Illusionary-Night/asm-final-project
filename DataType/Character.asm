INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/DataType/Character.inc
INCLUDE ./asm-final-project/MemOperation.inc
.data
	
.code
; ---------------------------------------------------------
; SetInGameAttribute
; Directly sets current HP, EP, and MP values.
; ---------------------------------------------------------
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

; ---------------------------------------------------------
; InitializeInGameAttribute
; Resets current stats (HP/EP/MP) to the Max values found in ResourceAttribute.
; ---------------------------------------------------------
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

; ---------------------------------------------------------
; CheckInGameStatEnough
; Checks if a specific attribute meets a required value.
; pFieldOffset: Offset of the attribute within the struct (e.g., offset of HP).
; ---------------------------------------------------------
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

; ---------------------------------------------------------
; OverlayInGameAttribute
; Applies changes to attributes (pAttr1 += pAttr2).
; TypeFlag 0 (Demand): "Transaction Check" - Only applies if result >= 0. Returns 1 if unaffordable.
; TypeFlag 1 (Effect): "Apply Force" - Applies change immediately. Clamps to 0 if negative.
; ---------------------------------------------------------
OverlayInGameAttribute PROC USES esi edi ebx ecx edx,   ; RETURN flag in eax 1= fail 0= success
    pAttr1:PTR INGAMEATTRIBUTE,
    pAttr2:PTR INGAMEATTRIBUTE,
    TypeFlag:DWORD            ; 0 = Demand, 1 = Effect

    mov esi, pAttr1           ; Base Attributes (Current Player)
    mov edi, pAttr2           ; Modifier Attributes (Cost or Effect)
    xor eax, eax              ; flag = 0

    ; ---------------------------
    ; �����p�� HP
    ; --- HP Logic ---
    mov ebx, (INGAMEATTRIBUTE PTR [edi]).HP
    mov ecx, (INGAMEATTRIBUTE PTR [esi]).HP
    add ecx, ebx              ; Calculate potential new value
    cmp TypeFlag, 0
    je checkDemandHP          ; If Demand mode, jump to check
checkEffectHP:                ; Effect Mode (Apply immediately)
    ; �ĪG�Ҧ��A�t���k�s
    cmp ecx, 0
    jge okHP
    mov (INGAMEATTRIBUTE PTR [esi]).HP, 0
    mov eax, 1                ; Set flag (maybe indicates death/exhaustion)
    jmp nextHP
okHP:
    mov (INGAMEATTRIBUTE PTR [esi]).HP, ecx
nextHP:
    ; ---------------------------
    ; �����p�� EP
    ; --- EP Logic (Same as HP) ---
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
    ; --- MP Logic (Same as HP) ---
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
; --- Demand Mode Checks ---
; If any stat drops below 0, fail the whole transaction.
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
    mov ebx, (INGAMEATTRIBUTE PTR [edi]).HP
    add (INGAMEATTRIBUTE PTR [esi]).HP, ebx
    mov ebx, (INGAMEATTRIBUTE PTR [edi]).EP
    add (INGAMEATTRIBUTE PTR [esi]).EP, ebx
    mov ebx, (INGAMEATTRIBUTE PTR [edi]).MP
    add (INGAMEATTRIBUTE PTR [esi]).MP, ebx
    mov eax, 0
    ret

failOverlay:
    mov eax, 1
    ret

OverlayInGameAttribute ENDP

; ---------------------------------------------------------
; SetResourceAttribute
; Sets all persistent resource stats (Max values, Money, Lives).
; ---------------------------------------------------------
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


; ---------------------------------------------------------
; InitializeResourceAttribute
; Sets default hardcoded values: HP=1000, EP/MP=100, Money=100, Lives=5.
; ---------------------------------------------------------
InitializeResourceAttribute PROC USES esi,
    pAttr:PTR RESOURCEATTRIBUTE

    mov esi, pAttr

    ; �����I�s SetResourceAttribute ������M�� 0
    INVOKE SetResourceAttribute, esi, 1000, 100, 100, 100, 5    ; �Ѽ�: maxhp, maxep, maxmp, money, lives

    ret
InitializeResourceAttribute ENDP

; ---------------------------------------------------------
; CheckMoneyEnough
; Returns EAX=1 if player has enough money, EAX=0 otherwise.
; ---------------------------------------------------------
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

; ---------------------------------------------------------
; CheckCharacterAlive
; Returns EAX=1 if Lives > 0, EAX=0 if dead.
; ---------------------------------------------------------
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