INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/SysInc/VirtualKeys.inc
INCLUDE ./asm-final-project/IO/input.inc

.data
    inputhandle DWORD ?
    inputRecord INPUT_RECORD <>
    eventNum DWORD ?
    lastKeyStatus DWORD 0
    mode DWORD ?
.code

WaitKeyPress proc uses ax virtualkey : DWORD
L1:
    INVOKE GetKeyState, virtualkey
    test ax, 8000h
    ;if the key is pressed, then the 15 bit of eax will be set(or say highest bit of ax)
    ;so take ax and 1000000000000000b do and operation, the last 14 bits must be 0,
    ;then if key is pressed, highest bit of ax = 1, after and operation will result in not 0, zero flag is set
    ;otherwise, highest bit of ax = 0, after and operation will result in 0, zero flag is set
    jnz outloop1
    jmp L1
outloop1:
    ret 2
WaitKeyPress endp

end