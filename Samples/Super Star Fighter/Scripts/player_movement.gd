extends SPlayer

@export var rotation_speed = 5.0
@export var hold_delay = 500
@export var max_hold = 1500
@export var hold_speed_multiplier = 2
@export var hold_dash = true

var press_start_time = 0.0
var holding = false


func _directional_input_movement(delta):
	velocity = linear_velocity.rotated(-rotation)

	if hold_dash:
		if Input.is_action_just_pressed("shoot"):
			press_start_time = Time.get_ticks_msec()
			holding = true
		if Input.is_action_just_released("shoot"):
			var diff = Time.get_ticks_msec() - press_start_time
			holding = false
			if diff > hold_delay:
				diff = min(diff, max_hold)
				velocity.y = (
					-inverse_lerp(hold_delay, max_hold, diff) * hold_speed_multiplier * top_speed.y
				)
				_update_velocity()

	if Input.is_action_pressed("move_up"):
		if !holding:
			velocity.y -= acceleration.y * delta
		if velocity.y > 0:
			velocity.y -= deceleration.y * delta
		velocity.y = clamp(velocity.y, -top_speed.y, top_speed.y)
		_update_velocity()
	elif Input.is_action_pressed("move_down"):
		if !holding:
			velocity.y += acceleration.y * delta
		if velocity.y < 0:
			velocity.y += deceleration.y * delta
		velocity.y = clamp(velocity.y, -top_speed.y, top_speed.y)
		_update_velocity()
	elif abs(velocity.y) > 0.001:
		if velocity.y < -0.001:
			velocity.y += min(deceleration.y * delta, abs(velocity.y))
		elif velocity.y > 0.001:
			velocity.y -= min(deceleration.y * delta, velocity.y)
		_update_velocity()

	if abs(velocity.x) > 0.001:
		if velocity.x < -0.001:
			velocity.x += min(deceleration.x * delta, abs(velocity.x))
		elif velocity.x > 0.001:
			velocity.x -= min(deceleration.x * delta, velocity.x)
		_update_velocity()

	if Input.is_action_pressed("move_left"):
		angular_velocity = -rotation_speed
	elif Input.is_action_pressed("move_right"):
		angular_velocity = rotation_speed
	else:
		angular_velocity = 0


func _update_velocity():
	if lock_to_screen:
		if (velocity.x > 0 && position.x >= screen_size.x) || (velocity.x < 0 && position.x <= 0):
			velocity.x = 0
		if (velocity.y > 0 && position.y >= screen_size.y) || (velocity.y < 0 && position.y <= 0):
			velocity.y = 0
	linear_velocity = velocity.rotated(rotation)
