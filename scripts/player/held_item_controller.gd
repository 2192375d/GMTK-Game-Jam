class_name HeldItemController
extends Node3D

var held_item: Interactable
var held_item_layer: int

func pick_up_item(interactable: Interactable) -> void:
	print("picking up item", interactable.name)
	held_item = interactable
	held_item_layer = held_item.collision_layer
	
	interactable.freeze = true
	#interactable.collision_shape.disabled = true
	interactable.collision_layer = 16

func drop_item() -> void:
	print("attemptiong to drop...")
	if held_item:
		print("dropping item", held_item.name)
		held_item.freeze = false
		#held_item.collision_shape.disabled = false
		held_item.collision_layer = held_item_layer
		held_item = null

func _process(_delta: float) -> void:
	if held_item:
		held_item.global_position = global_position
