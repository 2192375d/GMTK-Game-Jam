@abstract
extends RigidBody3D
class_name Interactable

@export var visual_mesh: MeshInstance3D # So a "glowy" version of it can be created
@export var collision_shape: CollisionShape3D # So it can be disabled

var on_cooldown: bool # In case the interactable doesn't want to be spam-interacted with
var mat = load("res://assets/materials/interact_material_unlit.tres")
var outline: MeshInstance3D

# Shows the red highlight for items that'll make you lose
var within_photo_area: bool = false
# Shows highlight when player can interact with it
var player_can_interact: bool = false

func _ready():
	outline = visual_mesh.duplicate() as MeshInstance3D
	outline.material_override = mat
	add_child(outline)
	outline.visible = false
	pass
	
func toggle_outline(toggle: bool):
	player_can_interact = toggle
	

@abstract
func on_e_interact(player: Player) -> Signal

@abstract
# Always instantanous 
func on_space_interact(player: Player) -> void
