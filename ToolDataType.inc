.NOLIST

TOOL STRUCT
	SLOT TOOLSLOT 16 DUP(<>)		; 描述道具的圖案，在形狀之外的範圍則以特殊字元'?'來表達不覆蓋
	SHAPE BYTE 16 DUP(<>)		; 每格以bool(0 or 1)表達該位置是否有形狀
	BPPOSITION COORD <>			; 描述該道具在背包中的位置
	RARITY   BYTE ?				; 表示稀有度(normal、rare、epic)，用在商店刷新機率
	COOLDOWN DWORD ?			; 冷卻時間，道具全都是週期性道具
	COOLDOWNMAX DWORD ?			; 冷卻時間上限
	TYPEID DWORD ?				; 道具種類編號
	UUID DWORD ?				; 道具唯一編號，定義時不用填，初始化時才需要
TOOL ENDS

MemClone PROTO : PTR BYTE, : PTR BYTE, : DWORD

SetProtoTool PROTO :PTR TOOL, :PTR TOOLSLOT, :PTR BYTE, :BYTE, :DWORD, :DWORD

CooldownUpdate_Tool PROTO :PTR TOOL

ExecuteTool PROTO :PTR TOOL
