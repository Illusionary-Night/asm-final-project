
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

	ret
SetTestTool  ENDP

END