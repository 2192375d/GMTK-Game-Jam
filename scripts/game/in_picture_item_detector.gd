extends Area3D
# TODO: Add to "no-no zone" (also rename no-no zone)
# TODO attach the signals as well don't forget!
# Or even make the "danger zone" it's own scene... that's the best idea

# Useful for the level to know if ur safe or not :>
var in_risk_items: Array[Interactable]

func _on_body_entered(body: Node3D) -> void:
	if body is Interactable:
		body.within_photo_area = true
		in_risk_items.append(body)

func _on_body_exited(body: Node3D) -> void:
	if body is Interactable:
		body.within_photo_area = false
		in_risk_items.erase(body)
