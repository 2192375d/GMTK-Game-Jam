extends CharacterBody3D

const SPEED = 5.0
const PUSH_FORCE: float = 1.0

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		$"Held Item Controller".position.x = 0.4 if direction.x > 0 else -0.4
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# Push all stuff that is in the way of the player
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is RigidBody3D:
			var push_dir = -collision.get_normal()
			
			push_dir.y = 0 
			push_dir = push_dir.normalized()
			
			collider.apply_central_impulse(push_dir * PUSH_FORCE * delta)
