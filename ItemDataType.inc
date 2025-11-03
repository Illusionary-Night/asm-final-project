.NOLIST

TOOL STRUCT
	SLOT TOOLSLOT 16 DUP(?)
	BPPOSITION COORD <>	;
	RARITY   BYTE ? 
	COOLDOWN DWORD ?
TOOL ENDS

SetTool PROTO,
	Object: PTR TOOL,
	Sources: PTR BYTE,  
	Rarity: BYTE,
	Cooldown: BYTE      

RotateTool PROTO,
	Object: PTR TOOL

MoveUpTool PROTO,
	Object: PTR TOOL

MoveDownTool PROTO,
	Object: PTR TOOL

MoveLeftTool PROTO,
	Object: PTR TOOL

MoveRightTool PROTO,
	Object: PTR TOOL
DepositTool PROTO,
	Object: PTR TOOL

CooldownUpdate_Tool PROTO,
	Object: PTR TOOL

ExecuteTool PROTO,
	Object: PTR TOOL
