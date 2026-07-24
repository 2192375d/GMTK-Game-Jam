extends Node

enum LevelEnum {
	LEVEL_DEBUG = 10,
	LEVEL1 = 101,
	LEVEL2 = 102,
	LEVEL3 = 103,
	LEVEL4 = 104,
	LEVEL5 = 105,
	LEVEL6 = 106,
	LEVEL7 = 107
}

func get_level_string(level_enum: LevelEnum) -> String:
	var string: String
	match level_enum:
		LevelEnum.LEVEL_DEBUG:
			string = "uid://6b0ucmt5u7st"
	
	return string
