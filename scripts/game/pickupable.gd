extends Interactable
class_name GarbagePickupable

# Indicates how much slower the player goes when they're holding this
@export var speed_debuff:= 1.0

var picked_up: bool = false
signal on_dropped
var player: Player

func on_e_interact(player: Player) -> Signal: # Item is now "picked up" by the player
	self.player = player # TODO TEMPORARY
	# Do things
	picked_up = true
	player.held_item_controller.pick_up_item(self)
	# Visualize that it's been picked up
	return on_dropped # Wait for this to finish

func on_space_interact(player: Player) -> void:
	apply_impulse(Vector3(1, 1, 1))
	on_cooldown = true
	player.pause_inputs = true
	# Make the player do a kick animation too lolol
	await get_tree().create_timer(0.5).timeout
	on_cooldown = false
	player.pause_inputs = false
	
func _process(_delta: float) -> void:
	if picked_up:
		await get_tree().process_frame

		# wait no it cannot be here the player controls inputs >:( 
		# TODO fix if it becomes problematic
		if Input.is_action_just_pressed("interact"):
			# Throw it
			picked_up = false
			player.held_item_controller.drop_item()
			on_dropped.emit()
