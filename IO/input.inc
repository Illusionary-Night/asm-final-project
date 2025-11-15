.NOLIST
IFNDEF __input
__input EQU 1

INCLUDE ./asm-final-project/SysInc/VirtualKeys.inc  ;this library defines keyboard keys, ex: VK...

WaitKeyPress PROTO, virtualkey : DWORD

TestKeyPress MACRO virtualkey
    INVOKE GetKeyState, virtualkey
    test ax, 8000h
ENDM
ENDIF