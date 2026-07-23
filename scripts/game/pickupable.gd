extends Interactable
class_name Pickupable

# Indicates how much slower the player goes when they're holding this
@export var speed_debuff:= 1.0

var picked_up: bool = false
signal on_dropped

func on_e_interact() -> Signal: # Item is now "picked up" by the player
	# Do things
	picked_up = true
	# Visualize that it's been picked up
	return on_dropped # Wait for this to finish

func on_space_interact() -> void:
	apply_impulse(Vector3(1, 1, 1))
	on_cooldown = true
	await get_tree().create_timer(0.5).timeout
	on_cooldown = false
	

func _process(_delta: float) -> void:
	if picked_up:
		await get_tree().process_frame
		if Input.is_action_just_pressed("interact"):
			# Throw it
			picked_up = false
			on_dropped.emit()
