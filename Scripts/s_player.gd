class_name SPlayer
extends RigidBody2D

signal player_died
signal health_changed(new_health)

enum MovementType {
	DIRECTIONAL_INPUT,
	CLICK_AND_MOVE,
}

export var health = 100
export(MovementType) var movement_type = MovementType.DIRECTIONAL_INPUT
export var top_speed = Vector2(350, 350)
export var acceleration = Vector2(450, 450)
export var deceleration = Vector2(600, 600)
export(PackedScene) var s_projectile

var velocity = Vector2.ZERO
onready var target = position


func change_health(change):
	health += change
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("player_died")


func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
	_check_shooting(event)


func _physics_process(delta):
	_movement(delta)


func _movement(delta):
	match movement_type:
		MovementType.DIRECTIONAL_INPUT:
			_directional_input_movement(delta)
		MovementType.CLICK_AND_MOVE:
			_click_and_move_movement()


func _directional_input_movement(delta):
	velocity = linear_velocity

	if Input.is_action_pressed("move_up"):
		velocity.y -= acceleration.y * delta
		if velocity.y > 0:
			velocity.y -= deceleration.y * delta
		_update_velocity()
	elif Input.is_action_pressed("move_down"):
		velocity.y += acceleration.y * delta
		if velocity.y < 0:
			velocity.y += deceleration.y * delta
		_update_velocity()

	if Input.is_action_pressed("move_left"):
		velocity.x -= acceleration.x * delta
		if velocity.x > 0:
			velocity.x -= deceleration.x * delta
		_update_velocity()
	elif Input.is_action_pressed("move_right"):
		velocity.x += acceleration.x * delta
		if velocity.x < 0:
			velocity.x += deceleration.x * delta
		_update_velocity()


func _click_and_move_movement():
	velocity = position.direction_to(target) * top_speed
	if position.distance_to(target) < 5:
		velocity = Vector2.ZERO
	_update_velocity()


func _update_velocity():
	velocity.x = clamp(velocity.x, -top_speed.x, top_speed.x)
	velocity.y = clamp(velocity.y, -top_speed.y, top_speed.y)

	linear_velocity = velocity


func _check_shooting(event):
	if !$ShootingCooldown.is_stopped():
		return
	if event.is_action_pressed("shoot_up"):
		_shoot_projectile(0, linear_velocity)
	if event.is_action_pressed("shoot_down"):
		_shoot_projectile(PI, linear_velocity)
	if event.is_action_pressed("shoot_right"):
		_shoot_projectile(PI / 2, linear_velocity)
	if event.is_action_pressed("shoot_left"):
		_shoot_projectile(-PI / 2, linear_velocity)


func _shoot_projectile(direction, launch_velocity):
	var projectile = s_projectile.instance() as SProjectile
	projectile.launch_velocity = launch_velocity
	projectile.rotation += direction
	projectile.position = position
	projectile.collision_mask |= (1 << 2)
	projectile.targets.append("Enemy")
	get_parent().add_child(projectile)
	$ShootingCooldown.start()
