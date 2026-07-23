class_name HeldItemController
extends Node3D

var held_item: Interactable

func pick_up_item(interactable: Interactable) -> void:
	held_item = interactable
	
	interactable.freeze = true
	interactable.collision_shape.disabled = true

func drop_item() -> void:
	if held_item:
		held_item.freeze = false
		held_item.collision_shape.disabled = false
		held_item = null

func _process(_delta: float) -> void:
	if held_item:
		held_item.global_position = global_position
