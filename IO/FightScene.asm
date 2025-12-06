INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/IO/graph.inc
INCLUDE ./asm-final-project/DataType/Character.inc
INCLUDE ./asm-final-project/IO/FightScene.inc

.data
    HPGraph BYTE " ***     *** ",
                 "*****   *****",
                 " *********** ",
                 "  *********  ",
                 "    *****    ",
                 "      *      ", 0

    SPGraph BYTE "******|******",
                 "******|******",
                 "******|******",
                 " *****|***** ",
                 "   ***|***   ",
                 "     *|*     ", 0
    
    MPGraph BYTE "     | |     ",
                 "     | |     ",
                 "    /   \    ",
                 "   /-----\   ",
                 "  /       \  ",
                 " /_________\ ", 0

    MoneyGraph BYTE "   _______   ",
                    "  /  | |  \  ",
                    " /  / __)  \ ",
                    " |  \__ \  | ",
                    " \  (   /  / ",
                    "  \__|_|__/  ", 0

    LivesGraph BYTE "      *      ",
                    "     ***     ",
                    "*************",
                    "  *********  ",
                    "    *****    ",
                    "  **     **  ", 0




    UserHpStr	BYTE "Hp: "
	UserEpStr	BYTE "Sp: "
	UserMpStr	BYTE "Mp: "
	UserMoneyStr    BYTE "Money: "
	UserLivesStr    BYTE "Lives: "
    GameProcessCursor COORD <>;<UserAttributeX,UserAttributeY>
    GameProcessText TEXT <>
    hintGraph PICTURE <>
    userBox RECTANGLE <>

.code

ShowFightStatus PROC uses ax bx ecx esi edi
    ret
ShowFightStatus ENDP

ShowCharInfo proc uses eax esi Char: PTR CHARACTERATTRIBUTE, Position: COORD
	
	mov esi, Char
	SetGameProcessCursor Position.X, Position.Y

	INVOKE SetText, OFFSET GameProcessText, OFFSET UserHpStr, 0Ah, GameProcessCursor, LENGTHOF UserHpStr
	INVOKE ShowText, OFFSET GameProcessText
	mov eax, (CHARACTERATTRIBUTE PTR [esi]).Ingame.HP
	call WriteInt
    inc GameProcessCursor.Y
    INVOKE SetPicture, OFFSET hintGraph, OFFSET HPGraph, 12, 13, 6, GameProcessCursor
    INVOKE ShowPicture, OFFSET hintGraph
    add GameProcessCursor.Y, textYGap

	INVOKE SetText, OFFSET GameProcessText, OFFSET UserEpStr, 0Ah, GameProcessCursor, LENGTHOF UserEpStr
	INVOKE ShowText, OFFSET GameProcessText
	mov eax, (CHARACTERATTRIBUTE PTR [esi]).Ingame.EP
	call WriteInt
    inc GameProcessCursor.Y
    INVOKE SetPicture, OFFSET hintGraph, OFFSET SPGraph, 8, 13, 6, GameProcessCursor
    INVOKE ShowPicture, OFFSET hintGraph
    add GameProcessCursor.Y, textYGap

	INVOKE SetText, OFFSET GameProcessText, OFFSET UserMpStr, 0Ah, GameProcessCursor, LENGTHOF UserMpStr
	INVOKE ShowText, OFFSET GameProcessText
	mov eax, (CHARACTERATTRIBUTE PTR [esi]).Ingame.MP
	call WriteInt
    inc GameProcessCursor.Y
    INVOKE SetPicture, OFFSET hintGraph, OFFSET MPGraph, 9, 13, 6, GameProcessCursor
    INVOKE ShowPicture, OFFSET hintGraph
    add GameProcessCursor.Y, textYGap

	INVOKE SetText, OFFSET GameProcessText, OFFSET UserMoneyStr, 0Ah, GameProcessCursor, LENGTHOF UserMoneyStr
	INVOKE ShowText, OFFSET GameProcessText
	mov eax, (CHARACTERATTRIBUTE PTR [esi]).Resource.MONEY
	call WriteInt
    inc GameProcessCursor.Y
    INVOKE SetPicture, OFFSET hintGraph, OFFSET MoneyGraph, 14, 13, 6, GameProcessCursor
    INVOKE ShowPicture, OFFSET hintGraph
    add GameProcessCursor.Y, textYGap

	INVOKE SetText, OFFSET GameProcessText, OFFSET UserLivesStr, 0Ah, GameProcessCursor, LENGTHOF UserLivesStr
	INVOKE ShowText, OFFSET GameProcessText
	mov eax, (CHARACTERATTRIBUTE PTR [esi]).Resource.LIVES
	call WriteInt
    inc GameProcessCursor.Y
    INVOKE SetPicture, OFFSET hintGraph, OFFSET LivesGraph, 14, 13, 6, GameProcessCursor
    INVOKE ShowPicture, OFFSET hintGraph
	add GameProcessCursor.Y, textYGap

	ret

ShowCharInfo endp

EraseCharInfo proc uses eax esi ecx Char: PTR CHARACTERATTRIBUTE, Position: COORD

	mov ecx, 5
	SetGameProcessCursor Position.X, Position.Y
	L1:
		INVOKE SetText, OFFSET GameProcessText, OFFSET UserMoneyStr, 0Ah, GameProcessCursor, 15
		INVOKE EraseText, OFFSET GameProcessText
		inc GameProcessCursor.Y
        INVOKE SetPicture, OFFSET hintGraph, OFFSET MoneyGraph, 14, 13, 7, GameProcessCursor
        INVOKE ErasePicture, OFFSET hintGraph
        add GameProcessCursor.Y, textYGap
	LOOP L1
	ret 

EraseCharInfo endp

ShowCharInfoGraph proc uses eax esi edx Char: PTR CHARACTERATTRIBUTE, Position: COORD
    SetGameProcessCursor Position.X, Position.Y
    add GameProcessCursor.X, textGraphXGap
    add GameProcessCursor.Y, upGraphYGap  ;set GameProcessCursor to right position
    mov esi, Char

    mov eax, 25
    imul (CHARACTERATTRIBUTE PTR [esi]).InGame.HP   ;25 * current HP stores in edx/eax
    idiv (CHARACTERATTRIBUTE PTR [esi]).Resource.MAXHP  ;25 * (current HP/max HP) stors in eax

    cmp ax, 1
    jle ZeroHP
    cmp ax, 25
    je FullHP
    jmp NormalHP
ZeroHP:
    INVOKE SetRectangle, OFFSET userBox, ' ', 255, 25, 3, GameProcessCursor
    INVOKE ShowRectangle, OFFSET userBox
    jmp FinishHP
FullHP:
    INVOKE SetRectangle, OFFSET userBox, ' ', 207, 25, 3, GameProcessCursor
    INVOKE ShowRectangle, OFFSET userBox
    jmp FinishHP
NormalHP:
    INVOKE SetRectangle, OFFSET userBox, ' ', 207, ax, 3, GameProcessCursor
    INVOKE ShowRectangle, OFFSET userBox
    add GameProcessCursor.X, ax

    mov dx, 25
    sub dx, ax
    cmp dx, 0
    INVOKE SetRectangle, OFFSET userBox, ' ', 255, dx, 3, GameProcessCursor
    INVOKE ShowRectangle, OFFSET userBox
    sub GameProcessCursor.X, ax
FinishHP:
    add GameProcessCursor.Y, GraphYGap

    mov eax, 25
    imul (CHARACTERATTRIBUTE PTR [esi]).InGame.EP   ;25 * current HP stores in edx/eax
    idiv (CHARACTERATTRIBUTE PTR [esi]).Resource.MAXEP  ;25 * (current HP/max HP) stors in eax

    cmp ax, 1
    jle ZeroSP
    cmp ax, 25
    je FullSP
    jmp NormalSP
ZeroSP:
    INVOKE SetRectangle, OFFSET userBox, ' ', 255, 25, 3, GameProcessCursor
    INVOKE ShowRectangle, OFFSET userBox
    jmp FinishSP
FullSP:
    INVOKE SetRectangle, OFFSET userBox, ' ', 143, 25, 3, GameProcessCursor
    INVOKE ShowRectangle, OFFSET userBox
    jmp FinishSP
NormalSP:
    INVOKE SetRectangle, OFFSET userBox, ' ', 143, ax, 3, GameProcessCursor
    INVOKE ShowRectangle, OFFSET userBox
    add GameProcessCursor.X, ax

    mov dx, 25
    sub dx, ax
    cmp dx, 0
    INVOKE SetRectangle, OFFSET userBox, ' ', 255, dx, 3, GameProcessCursor
    INVOKE ShowRectangle, OFFSET userBox
    sub GameProcessCursor.X, ax
FinishSP:
    add GameProcessCursor.Y, GraphYGap

    mov eax, 25
    imul (CHARACTERATTRIBUTE PTR [esi]).InGame.MP   ;25 * current HP stores in edx/eax
    idiv (CHARACTERATTRIBUTE PTR [esi]).Resource.MAXMP  ;25 * (current HP/max HP) stors in eax

    cmp ax, 1
    jle ZeroMP
    cmp ax, 25
    je FullMP
    jmp NormalMP
ZeroMP:
    INVOKE SetRectangle, OFFSET userBox, ' ', 255, 25, 3, GameProcessCursor
    INVOKE ShowRectangle, OFFSET userBox
    jmp FinishMP
FullMP:
    INVOKE SetRectangle, OFFSET userBox, ' ', 159, 25, 3, GameProcessCursor
    INVOKE ShowRectangle, OFFSET userBox
    jmp FinishMP
NormalMP:
    INVOKE SetRectangle, OFFSET userBox, ' ', 159, 25, 3, GameProcessCursor
    INVOKE ShowRectangle, OFFSET userBox
    add GameProcessCursor.X, ax

    mov dx, 25
    sub dx, ax
    cmp dx, 0
    INVOKE SetRectangle, OFFSET userBox, ' ', 255, dx, 3, GameProcessCursor
    INVOKE ShowRectangle, OFFSET userBox
    sub GameProcessCursor.X, ax
FinishMP:

ret 8

ShowCharInfoGraph endp

EraseCharInfoGraph proc uses ecx Char: PTR CHARACTERATTRIBUTE, Position: COORD
    SetGameProcessCursor Position.X, Position.Y
    add GameProcessCursor.X, textGraphXGap
    add GameProcessCursor.Y, upGraphYGap
    mov ecx, 3
L:
    INVOKE SetRectangle, OFFSET userBox, ' ', 0, 25, 3, GameProcessCursor
    INVOKE ShowRectangle, OFFSET userBox
    add GameProcessCursor.Y, GraphYGap
    loop L
ret 8
EraseCharInfoGraph endp

end