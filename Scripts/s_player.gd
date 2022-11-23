class_name SPlayer
extends RigidBody2D

signal player_died

enum MovementType {
	DIRECTIONAL_INPUT,
	CLICK_AND_MOVE,
}

export var health = 100
export(MovementType) var movement_type = MovementType.DIRECTIONAL_INPUT
export var top_speed = Vector2(350, 350)
export var acceleration = Vector2(450, 450)
export var deceleration = Vector2(600, 600)

var velocity = Vector2.ZERO
onready var target = position


func change_health(change):
	health += change
	if health <= 0:
		emit_signal("player_died")


func _physics_process(delta):
	_movement(delta)


func _movement(delta):
	match movement_type:
		MovementType.DIRECTIONAL_INPUT:
			_directional_input_movement(delta)
		MovementType.CLICK_AND_MOVE:
			_click_and_move_movement(delta)


func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()


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


func _click_and_move_movement(delta):
	velocity = position.direction_to(target) * top_speed
	if position.distance_to(target) < 5:
		velocity = Vector2.ZERO
	_update_velocity()


func _update_velocity():
	velocity.x = clamp(velocity.x, -top_speed.x, top_speed.x)
	velocity.y = clamp(velocity.y, -top_speed.y, top_speed.y)

	linear_velocity = velocity
