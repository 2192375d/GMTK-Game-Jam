extends Node3D

var held_item: Pickupable

func _ready() -> void:
	$"../Interaction Area".on_e_interact.connect(
		func(interactable: Interactable):
			if interactable is Pickupable:
				print("Does this run")
				held_item = interactable
				interactable.freeze = true
				interactable.collision_shape.disabled = true

	)
	
	$"../Interaction Area".on_e_interact_finished.connect(
		func(interactable: Interactable):
			print("Did this do the thing", interactable, held_item)
			if held_item == interactable:
				print("ah it probably didn't do that")
				held_item.freeze = false
				interactable.collision_shape.disabled = false
				held_item = null
				
	)

func _process(_delta: float) -> void:
	if held_item:
		held_item.global_position = global_position
