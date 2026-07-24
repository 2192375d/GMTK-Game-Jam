class_name PictureArea3D
extends Area3D

@export var capture_shape: CollisionShape3D


func get_capture_size() -> Vector2:
	var box_shape: BoxShape3D = capture_shape.shape as BoxShape3D
	var area_scale: Vector3 = global_transform.basis.get_scale()
	return Vector2(box_shape.size.x * absf(area_scale.x), box_shape.size.z * absf(area_scale.z))
