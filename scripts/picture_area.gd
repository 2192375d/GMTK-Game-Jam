extends Area2D

class_name PictureArea

@export var capture_shape: CollisionShape2D


func get_capture_size() -> Vector2:
	var rectangle_shape: RectangleShape2D = capture_shape.shape as RectangleShape2D
	return rectangle_shape.size * global_scale.abs()
