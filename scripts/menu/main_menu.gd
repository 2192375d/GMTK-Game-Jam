extends Control

@export var game_scene: PackedScene

func start_game(level_enum: LevelRegistry.LevelEnum) -> void:
	var game: Game = game_scene.instantiate()
	game.current_level_enum = level_enum
	get_tree().change_scene_to_node(game)

func _on_level_1_pressed() -> void:
	start_game(LevelRegistry.LevelEnum.LEVEL1)

func _on_level_2_pressed() -> void:
	start_game(LevelRegistry.LevelEnum.LEVEL2)

func _on_level_3_pressed() -> void:
	start_game(LevelRegistry.LevelEnum.LEVEL3)

func _on_level_4_pressed() -> void:
	start_game(LevelRegistry.LevelEnum.LEVEL4)

func _on_level_5_pressed() -> void:
	start_game(LevelRegistry.LevelEnum.LEVEL5)
