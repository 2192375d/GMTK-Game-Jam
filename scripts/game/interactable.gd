@abstract
extends RigidBody3D
class_name Interactable

@export var visual_mesh: MeshInstance3D # So a "glowy" version of it can be created
@export var collision_shape: CollisionShape3D # So it can be disabled

var on_cooldown: bool # In case the interactable doesn't want to be spam-interacted with
var mat = load("res://assets/materials/interact_material_unlit.tres")
var outline: MeshInstance3D

func _ready():
	outline = visual_mesh.duplicate() as MeshInstance3D
	outline.material_override = mat
	add_child(outline)
	outline.visible = false
	pass
	
func toggle_outline(toggle: bool):
	outline.visible = toggle

@abstract
func on_e_interact() -> Signal

@abstract
# Always instantanous 
func on_space_interact() -> void
