class_name PauseMenuLayer
extends CanvasLayer

const MAIN_MENU_PATH: String = "res://scenes/main_menu.tscn"


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		if get_tree().paused:
			resume_game()
		else:
			pause_game()
		get_viewport().set_input_as_handled()


func pause_game() -> void:
	visible = true
	get_tree().paused = true


func resume_game() -> void:
	get_tree().paused = false
	visible = false


func _on_resume_pressed() -> void:
	resume_game()


func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU_PATH)


func _on_restart_pressed() -> void:
	var game: Game = get_tree().current_scene as Game
	resume_game()
	game.restart_level()
