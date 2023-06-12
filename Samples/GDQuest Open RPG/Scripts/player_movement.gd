extends SPlayer

var moving_from_click = false


func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
		moving_from_click = true
		print("Clicked!")
	if event.is_action_pressed("interact"):
		interact_pressed = true
	if event.is_action_pressed("consume_1"):
		if health_consumable != null:
			health_consumable.consume()


func movement(delta):
	if moving_from_click:
		_click_and_move_movement()
	else:
		_directional_input_movement(delta)


func _click_and_move_movement():
	velocity = position.direction_to(target) * top_speed
	if position.distance_to(target) < 5:
		velocity = Vector2.ZERO
		moving_from_click = false
	_update_velocity()
