.NOLIST
IFNDEF __ToolDataType
__ToolDataType EQU 1
INCLUDE ./asm-final-project/DataType/Character.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc

TOOL STRUCT
	SLOT BYTE 16*SIZEOF TOOLSLOT DUP(?)	; 描述道具的圖案，在形狀之外的範圍則以特殊字元'?'來表達不覆蓋
	SHAPE BYTE 16 DUP(?)		; 每格以bool(0 or 1)表達該位置是否有形狀
	BPPOSITION COORD <>			; 描述該道具在背包中的位置
	RARITY   BYTE ?				; 表示稀有度(normal、rare、epic)，用在商店刷新機率
	COOLDOWN DWORD ?			; 冷卻時間，道具全都是週期性道具
	COOLDOWNMAX DWORD ?			; 冷卻時間上限
	TYPEID DWORD ?				; 道具種類編號
	UUID DWORD ?				; 道具唯一編號，定義時不用填，初始化時才需要
	ALLYDELTA CHARACTERATTRIBUTE <>		; 使用道具後對我方的屬性變化
	ENEMYDELTA CHARACTERATTRIBUTE <>		; 使用道具後對敵方的屬性變化
TOOL ENDS




CooldownUpdate_Tool PROTO :PTR TOOL

ExecuteTool PROTO :PTR TOOL

ShowTool PROTO :PTR TOOL


ENDIF