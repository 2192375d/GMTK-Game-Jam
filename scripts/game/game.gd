class_name Game
extends Node

@export var countdown_label: Label

@export var current_level_enum: LevelRegistry.LevelEnum = LevelRegistry.LevelEnum.LEVEL_DEBUG
@export var shot_animation: AnimationPlayer
@export var photo_viewport: SubViewport
@export var photo_camera: Camera2D
@export var photo_preview: TextureRect

@onready var current_time_elapsed: int = 0
@onready var current_time_index: int = 0
var current_level: Level = null

func _ready() -> void:
	var current_level_scene: PackedScene = load(LevelRegistry.get_level_string(current_level_enum))
	current_level = current_level_scene.instantiate()
	add_child(current_level)
	var picture_area: PictureArea = current_level.picture_area
	var capture_size: Vector2 = picture_area.get_capture_size()
	
	photo_viewport.world_2d = picture_area.get_world_2d()
	photo_viewport.size = Vector2i(capture_size)
	photo_camera.global_position = picture_area.global_position
	photo_camera.zoom = Vector2.ONE
	
	update_countdown_text()

func _capture_photo() -> void:
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
		current_time_index += 1
		shot_animation.play("flash")
		_capture_photo()
		update_countdown_text()
	
	if current_time_index > current_level.time_between_shots.size():
		print("level complete")

func update_countdown_text() -> void:
	countdown_label.text = "countdown: " + str(current_level.time_between_shots[current_time_index] - current_time_elapsed)
