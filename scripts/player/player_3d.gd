extends CharacterBody3D
class_name Player

const PUSH_FORCE: float = 1.0

@onready var held_item_controller: HeldItemController = $"Held Item Controller"
var pause_inputs:= false

func _physics_process(_delta: float) -> void:
	if pause_inputs: return
	velocity = $Movement.get_movement(transform)
	move_and_slide()

func push_things(delta: float):
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is RigidBody3D:
			var push_dir = -collision.get_normal()
			
			push_dir.y = 0 
			push_dir = push_dir.normalized()
			
			collider.apply_central_impulse(push_dir * PUSH_FORCE * delta)
