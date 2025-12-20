.NOLIST
IFNDEF __Character
__Character EQU 1

; --- Data Structures ---

; Current dynamic stats (changes frequently during gameplay)
INGAMEATTRIBUTE STRUCT
	HP SDWORD ?			; Health Points �ͩR��
	EP SDWORD ?			; Stamina Points �@�O��
	MP SDWORD ?			; Magic Points �]�O��
INGAMEATTRIBUTE ENDS

; Long-term stats and limits
RESOURCEATTRIBUTE STRUCT
	MAXHP SDWORD ?		; �ͩR�ȤW��
	MAXEP SDWORD ?		; �@�O�ȤW��
	MAXMP SDWORD ?		; �]�O�ȤW��
	MONEY SDWORD ?		;�����ƶq �Ψ��ʶR�D��
	LIVES SDWORD ?		;�ͩR�ƶq �i�Q���Ѧ���
RESOURCEATTRIBUTE ENDS

; Combined character data
CHARACTERATTRIBUTE STRUCT
	InGame INGAMEATTRIBUTE <>
	Resource RESOURCEATTRIBUTE <>
CHARACTERATTRIBUTE ENDS

;INGAME 

; --- Prototypes ---

; In-Game Attributes (HP/EP/MP)

SetInGameAttribute PROTO :PTR INGAMEATTRIBUTE, :SDWORD, :SDWORD, :SDWORD

InitializeInGameAttribute PROTO :PTR CHARACTERATTRIBUTE	;��l�ƹC�����ݩ�

CheckInGameStatEnough PROTO :PTR INGAMEATTRIBUTE, :PTR SDWORD, :SDWORD	;�P�_�O�_��������HP, EP, MP 

; Core Logic: Modifies stats based on Demand (check requirements) or Effect (apply damage/heal)
OverlayInGameAttribute PROTO :PTR INGAMEATTRIBUTE, :PTR INGAMEATTRIBUTE, :DWORD; �|�[�C�����ݩ� �Ѽ�3 = TypeFlag: 0 = Demand, 1 = Effect �ݨD�����L�Ĩæ^��1�beax


;RESOURCE
; Resource Attributes (Max stats/Money)

SetResourceAttribute PROTO :PTR RESOURCEATTRIBUTE, :SDWORD, :SDWORD, :SDWORD, :SDWORD, :SDWORD

InitializeResourceAttribute PROTO :PTR RESOURCEATTRIBUTE	;��l�Ƹ귽�ݩ�

;CHARACTER
; Utility Checks

CheckMoneyEnough PROTO :PTR CHARACTERATTRIBUTE, :SDWORD	;�P�_�O�_��������Money ;�^�Ǩ�eax, 1:�c, 0:�_

CheckCharacterAlive PROTO :PTR CHARACTERATTRIBUTE	;�^�Ǩ�eax, 1:����, 0:����

ENDIF