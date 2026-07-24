class_name PictureArea3D
extends Area3D

@export var capture_shape: CollisionShape3D

func get_capture_size() -> Vector2:
	var box_shape: BoxShape3D = capture_shape.shape as BoxShape3D
	var area_scale: Vector3 = global_transform.basis.get_scale()
	return Vector2(box_shape.size.x * absf(area_scale.x), box_shape.size.z * absf(area_scale.z))


# Useful for the level to know if ur safe or not
var in_risk_items: Array[Interactable]

func _on_body_entered(body: Node3D) -> void:
	if body is Interactable:
		body.within_photo_area = true
		in_risk_items.append(body)

func _on_body_exited(body: Node3D) -> void:
	if body is Interactable:
		body.within_photo_area = false
		in_risk_items.erase(body)
