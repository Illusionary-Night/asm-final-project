INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/Character.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
INCLUDE ./asm-final-project/MemOperation.inc

.data
	; test tool data---------------------------------------------------
	test_slot_info1 BYTE	"  **  ",
							" *  * ",
							" *  * ",
							"  **  ",
							" **** ",
							"  **  "
	test_slot_info2 BYTE	"XXXXXX",
							"XXXXXX",
							"XXXXXX",
							"XXXXXX",
							"XXXXXX",
							"XXXXXX"
	test_tool_shape BYTE	"1101",
							"1111",
							"1001",
							"1111"
	test_tool_slot TOOLSLOT 16 DUP(<>)
	test_tool Tool  <>
	test_ally_delta INGAMEATTRIBUTE  <>
	test_enemy_delta INGAMEATTRIBUTE  <>
	test_position COORD <4,1>
	test_UUID DWORD 0
	temp_position COORD <>
	test_name BYTE "Test Tool",0
	;--------------------------------------------------------------------
	; test tool data---------------------------------------------------
	fire_slot_info_00 BYTE	"      ",
							"      ",
							"      ",
							"      ",
							"      ",
							"      "
	fire_slot_info_01 BYTE	"      ",
							"      ",
							"    **",
							"     *",
							"     *",
							"     *"
	fire_slot_info_02 BYTE	"      ",
							"      ",
							"      ",
							"*     ",
							"**    ",
							"**    "
	fire_slot_info_03 BYTE	"      ",
							"      ",
							"      ",
							"      ",
							"      ",
							"      "
	fire_slot_info_10 BYTE	"      ",
							"    * ",
							"    * ",
							"   ** ",
							"  ****",
							"  ****"
	fire_slot_info_11 BYTE	"     *",
							"     *",
							"    **",
							"    **",
							"    **",
							"*   **"
	fire_slot_info_12 BYTE	"***   ",
							"****  ",
							"****  ",
							"******",
							"******",
							"******"
	fire_slot_info_13 BYTE	"   *  ",
							" ***  ",
							"****  ",
							"***** ",
							"******",
							"******"
	fire_slot_info_20 BYTE	"  ****",
							" *****",
							" *****",
							"******",
							"******",
							"******"
	fire_slot_info_21 BYTE	"******",
							"******",
							"******",
							"******",
							"******",
							"******"
	fire_slot_info_22 BYTE	"******",
							"******",
							"******",
							"******",
							"******",
							"******"
	fire_slot_info_23 BYTE	"******",
							"******",
							"******",
							"******",
							"******",
							"******"
	fire_slot_info_30 BYTE	" *****",
							" *****",
							"   ***",
							"     *",
							"      ",
							"      "
	fire_slot_info_31 BYTE	"******",
							"******",
							"******",
							"******",
							" *****",
							"    **"
	fire_slot_info_32 BYTE	"******",
							"******",
							"******",
							"******",
							"******",
							"****  "
	fire_slot_info_33 BYTE	"******",
							"***** ",
							"****  ",
							"***   ",
							"*     ",
							"      "
	fire_tool Tool  <>
	fire_tool_slot TOOLSLOT 16 DUP(<>)
	fire_tool_shape BYTE	"1111",
							"1111",
							"1111",
							"1111"
	fire_rarity BYTE 5
	fire_cooldown_max DWORD 4
	fire_typeid DWORD 1
	fire_ally_delta INGAMEATTRIBUTE  <0,0,0>
	fire_enemy_delta INGAMEATTRIBUTE  <-20,0,0>
	fire_name BYTE "Soul Flame",0, 0,0,0,0,0,0,0,0,0,0,0  ; 總共 20 bytes
	fire_price DWORD 5
	;--------------------------------------------------------------------






	test_tool2 Tool  <>

	tool_proto_database TOOL 100 DUP(<>)
	TPD_number DWORD 1
	tool_database TOOL 100 DUP(<>)
	TD_number DWORD 1
.code
SetProtoTool PROC USES esi edi eax,
	Object: PTR TOOL,
	Slot: PTR TOOLSLOT,
	Shape: PTR BYTE,
	Rarity: BYTE,
	CooldownMax: DWORD,
	TypeID: DWORD,
    AllyDelta: INGAMEATTRIBUTE,
    EnemyDelta: INGAMEATTRIBUTE,
	ToolName: PTR BYTE,
	Price: DWORD

    mov esi, Object
    
    lea edi, (TOOL PTR [esi]).SLOT
    INVOKE MemClone, edi, Slot, SIZEOF TOOLSLOT * 16
    
    lea edi, (TOOL PTR [esi]).SHAPE
    INVOKE MemClone, edi, Shape, SIZEOF BYTE * 16
    
    mov al, Rarity
    mov (TOOL PTR [esi]).RARITY, al
    
    mov eax, CooldownMax
    mov (TOOL PTR [esi]).COOLDOWNMAX, eax
    
    mov eax, TypeID
    mov (TOOL PTR [esi]).TYPEID, eax
    
    lea edi, (TOOL PTR [esi]).ALLYDELTA
    INVOKE MemClone, edi, ADDR AllyDelta, SIZEOF INGAMEATTRIBUTE

    lea edi, (TOOL PTR [esi]).ENEMYDELTA
    INVOKE MemClone, edi, ADDR EnemyDelta, SIZEOF INGAMEATTRIBUTE

	lea edi, (TOOL PTR [esi]).TOOLNAME
    INVOKE MemClone, edi, ToolName, SIZEOF BYTE * 20

	mov eax, Price
	mov (TOOL PTR [esi]).PRICE, eax

	mov edi, OFFSET tool_proto_database
	mov eax, SIZEOF TOOL
	mul TPD_number
	add edi, eax

	INVOKE MemClone, edi, esi, SIZEOF TOOL
	inc TPD_number

    ret
SetProtoTool ENDP

SetTestTool PROC USES esi ecx eax edx
	mov esi, OFFSET test_tool_slot
	
	mov ecx, 16
SlotRepeatLabel:
	INVOKE SetToolSlot, esi, OFFSET test_slot_info2, 0Ah
	add esi, SIZEOF TOOLSLOT
	LOOP SlotRepeatLabel

	INVOKE SetInGameAttribute, OFFSET test_ally_delta ,0 ,0 ,0
	INVOKE SetInGameAttribute, OFFSET test_enemy_delta ,0 ,0 ,0
	INVOKE SetProtoTool, OFFSET test_tool, OFFSET test_tool_slot, OFFSET test_tool_shape, 1, 4, 5, test_ally_delta, test_enemy_delta, OFFSET test_name,10
	
	lea edi, test_tool.BPPOSITION
	mov esi, OFFSET test_position
    INVOKE MemClone, edi, esi, SIZEOF COORD
	



	ret
SetTestTool  ENDP

SetAllTool PROC USES esi ecx eax edx
	mov esi, OFFSET fire_tool_slot
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_00, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_01, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_02, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_03, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_10, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_11, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_12, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_13, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_20, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_21, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_22, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_23, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_30, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_31, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_32, 0Ch
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET fire_slot_info_33, 0Ch

	INVOKE SetProtoTool, OFFSET fire_tool, OFFSET fire_tool_slot, OFFSET fire_tool_shape, fire_rarity, fire_cooldown_max, fire_typeid, fire_ally_delta, fire_enemy_delta, OFFSET fire_name, 500
	ret
SetAllTool  ENDP





GetToolByUUID PROC USES esi eax, 
	Object :PTR TOOL,
	UUID :DWORD

	mov esi, OFFSET tool_proto_database
	mov eax, SIZEOF TOOL
	mul UUID
	add esi, eax

	INVOKE MemClone, Object, esi, SIZEOF TOOL  
	ret
GetToolByUUID ENDP

CreateTool PROC USES eax esi,		; 在Database中創建一個新的Tool實例 Object_UUID:輸出參數 傳回新Tool的UUID
    Object_UUID : PTR DWORD,			; 傳回新Tool的UUID
    type_ID : DWORD						; Tool的原型ID
	
	; 用UUID從tool_proto_databasec獲取Tool原型

	mov esi, OFFSET tool_proto_database	
    mov eax, SIZEOF TOOL
	mul type_ID
	add esi, eax
	
	; 複製Tool原型到tool_database的下一個空位
	
	mov edi, OFFSET tool_database
	mov eax, SIZEOF TOOL
	mul TD_number
	add edi, eax

	; 複製Tool資料
	INVOKE MemClone, edi, esi, SIZEOF TOOL

	; 更新Tool的UUID
	mov eax, TD_number					; 取得目前Tool Database的數量
	mov (TOOL PTR [edi]).UUID, eax
	
	; 傳回Tool的UUID
	mov edi, Object_UUID
	mov [edi], eax

	inc TD_number						; Tool Database數量加1
    ret
CreateTool ENDP


ToolTest PROC
	INVOKE SetTestTool	
	;INVOKE CreateTool, OFFSET test_UUID, 0
	INVOKE GetToolByUUID, OFFSET test_tool2, test_UUID
	lea edi, test_tool2.BPPOSITION
	mov esi, OFFSET test_position
    INVOKE MemClone, edi, esi, SIZEOF COORD
	INVOKE ShowTool, OFFSET test_tool2
	ret
ToolTest ENDP

END