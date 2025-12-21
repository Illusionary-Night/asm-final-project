.NOLIST
IFNDEF __ToolDataType
__ToolDataType EQU 1
INCLUDE ./asm-final-project/DataType/Character.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc

; --- Data Structure ---
TOOL STRUCT
	; Visual & Physical properties
	SLOT BYTE 16*SIZEOF TOOLSLOT DUP(?)	; �y�z�D�㪺�ϮסA�b�Ϊ����~���d��h�H�S���r��'?'�Ӫ��F���л\
	SHAPE BYTE 16 DUP(?)		; �C��Hbool(0 or 1)���F�Ӧ�m�O�_���Ϊ�
	BPPOSITION COORD <>			; �y�z�ӹD��b�I�]������m
	RARITY   BYTE ?				; ���ܵ}����(normal�Brare�Bepic)�A�Φb�ө���s���v
	COOLDOWN DWORD ?			; �N�o�ɶ��A�D������O�g���ʹD��
	COOLDOWNMAX DWORD ?			; �N�o�ɶ��W��
	TYPEID DWORD ?				; �D������s��
	UUID DWORD ?				; �D��ߤ@�s���A�w�q�ɤ��ζ�A��l�Ʈɤ~�ݭn
	ALLYDELTA INGAMEATTRIBUTE <>		; �ϥιD����ڤ誺�ݩ��ܤ�
	ENEMYDELTA INGAMEATTRIBUTE <>		; �ϥιD����Ĥ誺�ݩ��ܤ�
	TOOLNAME BYTE 20 DUP(?)			; �D��W��
	PRICE DWORD ?					; �D�����
TOOL ENDS


; --- Prototypes ---

CooldownUpdate_Tool PROTO :PTR TOOL		; Updates timer, returns 1 if ready

;ExecuteTool PROTO :PTR TOOL				; (Not implemented in .asm provided)


ShowTool PROTO :PTR TOOL


ENDIF