
INCLUDE ./asm-final-project/SysInc/Irvine32.inc
INCLUDE ./asm-final-project/DataType/GameDataType.inc
INCLUDE ./asm-final-project/DataType/Character.inc
INCLUDE ./asm-final-project/DataType/ToolDataType.inc
.data
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
	test_tool_shape BYTE	"1000",
							"0000",
							"0000",
							"0000",
							"0000"
	test_tool_slot TOOLSLOT 16 DUP(<>)
	test_tool Tool  <>
	test_ally_delta CHARACTERATTRIBUTE  <>
	test_enemy_delta CHARACTERATTRIBUTE  <>
	test_position COORD <4,1>
	temp_position COORD <>
.code
SetTestTool PROC
	mov esi, OFFSET test_tool_slot
	INVOKE SetToolSlot, esi, OFFSET test_slot_info1, 0Ah
	mov ecx, 15
NullSlotRepeatLabel:
	add esi, SIZEOF TOOLSLOT
	INVOKE SetToolSlot, esi, OFFSET test_slot_info2, 0Ah
	LOOP NullSlotRepeatLabel
	INVOKE SetCharacterAttribute, OFFSET test_ally_delta ,0 ,0 ,0 ,0 ,0 ,0 ,0
	INVOKE SetCharacterAttribute, OFFSET test_ally_delta ,0 ,0 ,0 ,0 ,0 ,0 ,0
	INVOKE SetProtoTool, OFFSET test_tool, OFFSET test_tool_slot, OFFSET test_tool_shape, 1, 4, 5, test_ally_delta, test_enemy_delta
	


	mov esi, OFFSET test_tool.SLOT
	mov ecx, 0
	
	mov dx, test_position.Y
	mov temp_position.Y, dx

OuterLoop:
	mov eax, 0
	
	mov dx, test_position.X
	mov temp_position.X, dx

InnerLoop:

	INVOKE ShowToolSlot, esi, temp_position
	
	add esi, SIZEOF TOOLSLOT
	
	inc eax
	add WORD PTR temp_position.X, 7


	cmp eax, 4
	jb InnerLoop
	
	inc ecx
	add WORD PTR temp_position.Y, 7
	
	cmp ecx, 4
	jb OuterLoop
	
	ret
SetTestTool  ENDP
END