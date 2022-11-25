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
export(PackedScene) var s_projectile_shooter

var velocity = Vector2.ZERO
var enemy_mask = 1 << 2
var enemy_group = "Enemy"
onready var target = position


func _ready():
	_add_shooter()


func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()


func _physics_process(delta):
	_movement(delta)


func change_health(change):
	health += change
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("player_died")


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


func _add_shooter():
	if s_projectile_shooter == null:
		return
	var shooter = s_projectile_shooter.instance() as SProjectileShooter
	shooter.init([enemy_group], enemy_mask)
	add_child(shooter)
