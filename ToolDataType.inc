.NOLIST

TOOL STRUCT
	SLOT TOOLSLOT 16 DUP(<>)		; �y�z�D�㪺�ϮסA�b�Ϊ����~���d��h�H�S���r��'?'�Ӫ��F���л\
	SHAPE BYTE 16 DUP(<>)		; �C��Hbool(0 or 1)���F�Ӧ�m�O�_���Ϊ�
	BPPOSITION COORD <>			; �y�z�ӹD��b�I�]������m
	RARITY   BYTE ?				; ���ܵ}����(normal�Brare�Bepic)�A�Φb�ө���s���v
	COOLDOWN DWORD ?			; �N�o�ɶ��A�D������O�g���ʹD��
	COOLDOWNMAX DWORD ?			; �N�o�ɶ��W��
	TYPEID DWORD ?				; �D������s��
	UUID DWORD ?				; �D��ߤ@�s���A�w�q�ɤ��ζ�A��l�Ʈɤ~�ݭn
TOOL ENDS

MemClone PROTO : PTR BYTE, : PTR BYTE, : DWORD

SetProtoTool PROTO :PTR TOOL, :PTR TOOLSLOT, :PTR BYTE, :BYTE, :DWORD, :DWORD

CooldownUpdate_Tool PROTO :PTR TOOL

ExecuteTool PROTO :PTR TOOL