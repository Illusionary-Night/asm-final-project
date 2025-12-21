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
	; fire tool data---------------------------------------------------
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
	fire_tool_shape BYTE	"0110",
							"1111",
							"1111",
							"1111"
	fire_rarity BYTE 5
	fire_cooldown_max DWORD 3
	fire_typeid DWORD 1
	fire_ally_delta INGAMEATTRIBUTE  <-50,+10,+10>
	fire_enemy_delta INGAMEATTRIBUTE  <-150,0,0>
	fire_name BYTE "Soul Flame",0, 0,0,0,0,0,0,0,0,0,0,0  ; 總共 20 bytes
	fire_price DWORD 40
	;--------------------------------------------------------------------

	; magic_orb tool data---------------------------------------------------

	magic_orb_slot_info_00 BYTE	"....::",
							    "..::##",
								".:##++",
								":#++==",
								":#+=::",
								":#=::="
	magic_orb_slot_info_01 BYTE	"::....",
								"##::..",
								"++##:.",
								"==++#:",
								"::=+#:",
								"=::=#:"
	magic_orb_slot_info_02 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	magic_orb_slot_info_03 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	magic_orb_slot_info_10 BYTE	":#=::=",
	                            ":#+=::",
								":#++==",
								".:##++",
								"..::##",
								"....::"
	magic_orb_slot_info_11 BYTE	"=::=#:",
								"::=+#:",
								"==++#:",
								"++##:.",
								"##::..",
								"::...."
	magic_orb_slot_info_12 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	magic_orb_slot_info_13 BYTE	"      ",
	                            "      ",
								"      ",
								"      ",
								"      ",
								"      "
	magic_orb_slot_info_20 BYTE	"      ",
	                            "      ",
								"      ",
								"      ",
								"      ",
								"      "
	magic_orb_slot_info_21 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	magic_orb_slot_info_22 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	magic_orb_slot_info_23 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	magic_orb_slot_info_30 BYTE	"      ",
	                            "      ",
								"      ",
								"      ",
								"      ",
								"      "
	magic_orb_slot_info_31 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	magic_orb_slot_info_32 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	magic_orb_slot_info_33 BYTE	"      ",
	                            "      ",
								"      ",
								"      ",
								"      ",
								"      "
	
	magic_orb_tool Tool  <>
	magic_orb_tool_slot TOOLSLOT 16 DUP(<>)
	magic_orb_tool_shape BYTE	"1100",
								"1100",
								"0000",
								"0000"
	magic_orb_rarity BYTE 5
	magic_orb_cooldown_max DWORD 1
	magic_orb_typeid DWORD 1
	magic_orb_ally_delta INGAMEATTRIBUTE  <0,0,-15>
	magic_orb_enemy_delta INGAMEATTRIBUTE  <-150,-10,0>
	magic_orb_name BYTE "Magic Orb",0,0,0,0,0,0,0,0,0,0,0 ; 總共 20 bytes
	magic_orb_price DWORD 40
	;--------------------------------------------------------------------


	; arcane_blade tool data---------------------------------------------------

	arcane_blade_slot_info_00 BYTE	" ./\. ",
							    ".//\\.",
								":i||i:",
								":||||:",
								":||||:",
								" !||! "
	arcane_blade_slot_info_01 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	arcane_blade_slot_info_02 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	arcane_blade_slot_info_03 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	arcane_blade_slot_info_10 BYTE	"[=++=]",
	                            "[=++=]",
								" :||: ",
								" :||: ",
								":{}{}:",
								" .{}. "
	arcane_blade_slot_info_11 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	arcane_blade_slot_info_12 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	arcane_blade_slot_info_13 BYTE	"      ",
	                            "      ",
								"      ",
								"      ",
								"      ",
								"      "
	arcane_blade_slot_info_20 BYTE	"      ",
	                            "      ",
								"      ",
								"      ",
								"      ",
								"      "
	arcane_blade_slot_info_21 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	arcane_blade_slot_info_22 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	arcane_blade_slot_info_23 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	arcane_blade_slot_info_30 BYTE	"      ",
	                            "      ",
								"      ",
								"      ",
								"      ",
								"      "
	arcane_blade_slot_info_31 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	arcane_blade_slot_info_32 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	arcane_blade_slot_info_33 BYTE	"      ",
	                            "      ",
								"      ",
								"      ",
								"      ",
								"      "
	
	arcane_blade_tool Tool  <>
	arcane_blade_tool_slot TOOLSLOT 16 DUP(<>)
	arcane_blade_tool_shape BYTE	"1000",
									"1000",
									"0000",
									"0000"
	arcane_blade_rarity BYTE 5
	arcane_blade_cooldown_max DWORD 2
	arcane_blade_typeid DWORD 1
	arcane_blade_ally_delta INGAMEATTRIBUTE  <0,-10,-10>
	arcane_blade_enemy_delta INGAMEATTRIBUTE  <-100,0,0>
	arcane_blade_name BYTE "Arcane Blade",0,0,0,0,0,0,0,0 ; 總共 20 bytes
	arcane_blade_price DWORD 20
	;--------------------------------------------------------------------
	; the_grace_cross tool data---------------------------------------------------

	the_grace_cross_slot_info_00 BYTE	"      ",
							    "      ",
							    "      ",
							    "GRACEM",
							    "SPIRIT",
							    "      "
	the_grace_cross_slot_info_01 BYTE	"HOLYGR",
								"ACEAWE",
								"VIRTUE",
								"ERCYLI",
								"EREDEM",
								"EFAITH"
	the_grace_cross_slot_info_02 BYTE	"      ",
								"      ",
								"      ",
								"GHTHOP",
								"PTIONA",
								"      "
	the_grace_cross_slot_info_03 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	the_grace_cross_slot_info_10 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	the_grace_cross_slot_info_11 BYTE	"ATONEM",
								"ENTSAL",
								"VATION",
								"DELIVE",
								"ERANCE",
								"DIVINE"
	the_grace_cross_slot_info_12 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	the_grace_cross_slot_info_13 BYTE	"      ",
	                            "      ",
								"      ",
								"      ",
								"      ",
								"      "
	the_grace_cross_slot_info_20 BYTE	"      ",
	                            "      ",
								"      ",
								"      ",
								"      ",
								"      "
	the_grace_cross_slot_info_21 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	the_grace_cross_slot_info_22 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	the_grace_cross_slot_info_23 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	the_grace_cross_slot_info_30 BYTE	"      ",
	                            "      ",
								"      ",
								"      ",
								"      ",
								"      "
	the_grace_cross_slot_info_31 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	the_grace_cross_slot_info_32 BYTE	"      ",
								"      ",
								"      ",
								"      ",
								"      ",
								"      "
	the_grace_cross_slot_info_33 BYTE	"      ",
	                            "      ",
								"      ",
								"      ",
								"      ",
								"      "
	
	the_grace_cross_tool Tool  <>
	the_grace_cross_tool_slot TOOLSLOT 16 DUP(<>)
	the_grace_cross_tool_shape BYTE	"1110",
								"0100",
								"0000",
								"0000"
	the_grace_cross_rarity BYTE 5
	the_grace_cross_cooldown_max DWORD 9
	the_grace_cross_typeid DWORD 1
	the_grace_cross_ally_delta INGAMEATTRIBUTE  <+500,+50,-50>
	the_grace_cross_enemy_delta INGAMEATTRIBUTE  <0,0,0>
	the_grace_cross_name BYTE "The Grace Cross",0,0,0,0,0
	the_grace_cross_price DWORD 40
	;--------------------------------------------------------------------





	test_tool2 Tool  <>

	tool_proto_database TOOL 100 DUP(<>)
	TPD_number DWORD 1
	tool_database TOOL 100 DUP(<>)
	TD_number DWORD 1
.code
; ------------------------------------------------------------
; SetProtoTool
; Initialize a tool prototype and store it into prototype database
; ------------------------------------------------------------
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

    mov esi, Object		; Target TOOL object
    
	; Copy slot graphics
    lea edi, (TOOL PTR [esi]).SLOT
    INVOKE MemClone, edi, Slot, SIZEOF TOOLSLOT * 16
    
	; Copy shape data
    lea edi, (TOOL PTR [esi]).SHAPE
    INVOKE MemClone, edi, Shape, SIZEOF BYTE * 16
    
	; Set basic attributes
    mov al, Rarity
    mov (TOOL PTR [esi]).RARITY, al
    
    mov eax, CooldownMax
    mov (TOOL PTR [esi]).COOLDOWNMAX, eax
    
    mov eax, TypeID
    mov (TOOL PTR [esi]).TYPEID, eax
    
	; Copy ally / enemy attribute effects
    lea edi, (TOOL PTR [esi]).ALLYDELTA
    INVOKE MemClone, edi, ADDR AllyDelta, SIZEOF INGAMEATTRIBUTE

    lea edi, (TOOL PTR [esi]).ENEMYDELTA
    INVOKE MemClone, edi, ADDR EnemyDelta, SIZEOF INGAMEATTRIBUTE

	; Copy tool name
	lea edi, (TOOL PTR [esi]).TOOLNAME
    INVOKE MemClone, edi, ToolName, SIZEOF BYTE * 20

	; Set price
	mov eax, Price
	mov (TOOL PTR [esi]).PRICE, eax

	; Store prototype into prototype database
	mov edi, OFFSET tool_proto_database
	mov eax, SIZEOF TOOL
	mul TPD_number
	add edi, eax

	INVOKE MemClone, edi, esi, SIZEOF TOOL
	inc TPD_number

    ret
SetProtoTool ENDP

; ------------------------------------------------------------
; SetTestTool
; Create a simple test tool for debugging
; ------------------------------------------------------------
SetTestTool PROC USES esi ecx eax edx
	mov esi, OFFSET test_tool_slot
	
	; Initialize all slots
	mov ecx, 16
SlotRepeatLabel:
	INVOKE SetToolSlot, esi, OFFSET test_slot_info2, 0Ah
	add esi, SIZEOF TOOLSLOT
	LOOP SlotRepeatLabel

	; Initialize attributes
	INVOKE SetInGameAttribute, OFFSET test_ally_delta ,0 ,0 ,0
	INVOKE SetInGameAttribute, OFFSET test_enemy_delta ,0 ,0 ,0
	; Register test tool prototype
	INVOKE SetProtoTool, OFFSET test_tool, OFFSET test_tool_slot, OFFSET test_tool_shape, 1, 4, 5, test_ally_delta, test_enemy_delta, OFFSET test_name,10
	
	; Set backpack position
	lea edi, test_tool.BPPOSITION
	mov esi, OFFSET test_position
    INVOKE MemClone, edi, esi, SIZEOF COORD
	



	ret
SetTestTool  ENDP

; ------------------------------------------------------------
; SetAllTool
; Initialize all predefined tools in the game
; ------------------------------------------------------------
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

	INVOKE SetProtoTool, OFFSET fire_tool, OFFSET fire_tool_slot, OFFSET fire_tool_shape, fire_rarity, fire_cooldown_max, fire_typeid, fire_ally_delta, fire_enemy_delta, OFFSET fire_name, fire_price
	

	mov esi, OFFSET magic_orb_tool_slot
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_00, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_01, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_02, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_03, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_10, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_11, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_12, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_13, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_20, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_21, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_22, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_23, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_30, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_31, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_32, 0Bh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET magic_orb_slot_info_33, 0Bh
	INVOKE SetProtoTool, OFFSET magic_orb_tool, OFFSET magic_orb_tool_slot, OFFSET magic_orb_tool_shape, magic_orb_rarity, magic_orb_cooldown_max, magic_orb_typeid, magic_orb_ally_delta, magic_orb_enemy_delta, OFFSET magic_orb_name, magic_orb_price
	
	mov esi, OFFSET arcane_blade_tool_slot
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_00, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_01, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_02, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_03, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_10, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_11, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_12, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_13, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_20, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_21, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_22, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_23, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_30, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_31, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_32, 06h
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET arcane_blade_slot_info_33, 06h
	INVOKE SetProtoTool, OFFSET arcane_blade_tool, OFFSET arcane_blade_tool_slot, OFFSET arcane_blade_tool_shape, arcane_blade_rarity, arcane_blade_cooldown_max, arcane_blade_typeid, arcane_blade_ally_delta, arcane_blade_enemy_delta, OFFSET arcane_blade_name, arcane_blade_price
	
	mov esi, OFFSET the_grace_cross_tool_slot
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_00, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_01, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_02, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_03, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_10, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_11, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_12, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_13, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_20, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_21, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_22, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_23, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_30, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_31, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_32, 0Eh
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET the_grace_cross_slot_info_33, 0Eh
	INVOKE SetProtoTool, OFFSET the_grace_cross_tool, OFFSET the_grace_cross_tool_slot, OFFSET the_grace_cross_tool_shape, the_grace_cross_rarity, the_grace_cross_cooldown_max, the_grace_cross_typeid, the_grace_cross_ally_delta, the_grace_cross_enemy_delta, OFFSET the_grace_cross_name, the_grace_cross_price

	ret
SetAllTool  ENDP



; ------------------------------------------------------------
; GetToolByUUID
; Copy tool prototype by UUID into target object
; ------------------------------------------------------------

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

; ------------------------------------------------------------
; CreateTool
; Create a runtime tool instance from prototype database
; ------------------------------------------------------------
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

; ------------------------------------------------------------
; ToolTest
; Simple tool system test
; ------------------------------------------------------------
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