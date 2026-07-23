extends Area3D

var all_interactables: Array[Interactable]
var closest_interactable: Interactable
var ignore_interactions: bool # Used when an item is already held, because pressing interact again would "throw" the item until it's dropped

signal on_space_interact(interactable: Interactable)

signal on_e_interact(interactable: Interactable)
signal on_e_interact_finished(interactable: Interactable)

# Updates what is lit up (and unlights whatever is visible)
# If we ignore interactions, it will always be unlit
func _process(_delta: float) -> void:
	check_for_interaction()
	update_glowy()

# If the body leaves it automatically is unlit (always)
func _on_body_exited(body: Node3D) -> void:
	if body is Interactable: 
		body.toggle_outline(false)

func update_glowy():
	# Get all interactables not on cooldown
	var filter = get_overlapping_bodies().filter(func(a): return a is Interactable and not (a as Interactable).on_cooldown)
	all_interactables.assign(filter)
	
	all_interactables.sort_custom(
		func(a, b): return a.global_position.distance_to($"..".global_position) < b.global_position.distance_to($"..".global_position)
	)
	
	closest_interactable = null if all_interactables.size() <= 0 else all_interactables[0]
	
	if all_interactables.size() > 0:
		for interactable in all_interactables:
			if interactable == closest_interactable:
				closest_interactable.toggle_outline(not ignore_interactions)
			else:
				interactable.toggle_outline(false)
	
	
func check_for_interaction():
	if closest_interactable: 
		# So you cant immediately interact with the next object
		await get_tree().process_frame
		if Input.is_action_just_pressed("space"):
			closest_interactable.on_space_interact()
			on_space_interact.emit(closest_interactable)
		if Input.is_action_just_pressed("interact"):
			print("did this do anything")
			ignore_interactions = true
			
			# Notify everyone that something got interacted with
			var old_closest_interactable = closest_interactable
			on_e_interact.emit(old_closest_interactable)
			# Wait for the interaction to finish before we can interact with another object
			await closest_interactable.on_e_interact()
			on_e_interact_finished.emit(old_closest_interactable)
			
			ignore_interactions = false
