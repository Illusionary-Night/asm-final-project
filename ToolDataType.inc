.NOLIST

TOOL STRUCT
	SLOT TOOLSLOT 16 DUP(?)
	BPPOSITION COORD <>	
	RARITY   BYTE ? 
	COOLDOWN DWORD ?
TOOL ENDS

SetTool PROTO,
	Object: PTR TOOL,
	Sources: PTR BYTE,
	Length: BYTE,
	Rarity: BYTE,
	Cooldown: DWORD      

CooldownUpdate_Tool PROTO,
	Object: PTR TOOL

ExecuteTool PROTO,
	Object: PTR TOOL
