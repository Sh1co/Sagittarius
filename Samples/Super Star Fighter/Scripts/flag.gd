extends RigidBody2D

var locked = false


func _input(event):
	if event.is_action_pressed("interact"):
		locked = false
		var pos = global_position
		var level = get_parent().get_parent()
		get_parent().remove_child(self)
		level.add_child(self)
		global_position = pos
		freeze = false
		$CollisionShape2D.disabled = false


func _on_body_entered(body):
	if body.is_in_group("Player") && !locked:
		locked = true
		$CollisionShape2D.disabled = true
		var pos = global_position
		get_parent().remove_child(self)
		body.add_child(self)
		global_position = pos
		freeze = true
