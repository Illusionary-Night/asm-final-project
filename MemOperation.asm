INCLUDE Irvine32.inc

.data
	
.code
MemClone PROC USES esi edi ecx, Object:PTR BYTE, Source:PTR BYTE, _Length:DWORD
    mov esi, Source
    mov edi, Object
    mov ecx, _Length
    rep movsb
    ret
MemClone ENDP

END