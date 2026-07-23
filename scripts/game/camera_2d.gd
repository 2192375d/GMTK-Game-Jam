extends Camera2D


func _ready() -> void:
	var game: Game = get_tree().current_scene as Game
	
	global_position = game.current_level.picture_area.global_position
