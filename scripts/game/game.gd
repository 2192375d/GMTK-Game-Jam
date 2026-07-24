class_name Game
extends Node

const PHOTO_PIXELS_PER_WORLD_UNIT: int = 60

@export var countdown_label: Label

@export var current_level_enum: LevelRegistry.LevelEnum = LevelRegistry.LevelEnum.LEVEL_DEBUG
@export var shot_animation: AnimationPlayer
@export var photo_preview: TextureRect

@onready var current_time_elapsed: int = 0
@onready var current_time_index: int = 0
var current_level: Level = null

func _ready() -> void:
	var current_level_scene: PackedScene = load(LevelRegistry.get_level_string(current_level_enum))
	current_level = current_level_scene.instantiate()
	add_child(current_level)

	var picture_area: PictureArea3D = current_level.picture_area
	var photo_viewport: SubViewport = current_level.photo_viewport
	var photo_camera: Camera3D = current_level.photo_camera
	var capture_size: Vector2 = picture_area.get_capture_size()
	
	photo_viewport.world_3d = current_level.get_world_3d()
	photo_viewport.size = Vector2i(capture_size * PHOTO_PIXELS_PER_WORLD_UNIT)
	photo_camera.size = capture_size.y
	
	update_countdown_text()
	update_level(0)

func _capture_photo() -> void:
	var photo_viewport: SubViewport = current_level.photo_viewport

	photo_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	await RenderingServer.frame_post_draw

	var photo_image: Image = photo_viewport.get_texture().get_image()
	var photo_texture: ImageTexture = ImageTexture.create_from_image(photo_image)
	photo_preview.texture = photo_texture

func _on_timer_timeout() -> void:
	current_time_elapsed += 1
	update_countdown_text()
	
	if current_time_elapsed >= current_level.time_between_shots[current_time_index]:
		
		current_time_elapsed = 0
		shot_animation.play("flash")
		_capture_photo()
		update_countdown_text()
		if current_level.picture_area.in_risk_items.size() > 0:
			print("YOU FAILED THE LEVEL!")
			# Reload the level by adding the stuff back in place somehow???
			return
		else:
			# Continue and update the garbage to deal with
			current_time_index += 1
			update_level(current_time_index)
	
	if current_time_index > current_level.time_between_shots.size():
		print("level complete")

func update_countdown_text() -> void:
	countdown_label.text = "countdown: " + str(current_level.time_between_shots[current_time_index] - current_time_elapsed)
	
func update_level(index: int):
	var current_garbage_pattern = current_level.garbage_patterns_root.get_child(index)
	for child in current_level.garbage_patterns_root.get_children():
		if child == current_garbage_pattern:
			child.visible = true
			child.process_mode = Node.PROCESS_MODE_INHERIT
		else:
			child.visible = false
			child.process_mode = Node.PROCESS_MODE_DISABLED
