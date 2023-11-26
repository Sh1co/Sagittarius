class_name SPlayer
extends RigidBody2D

signal player_died
signal health_changed(new_health)

enum MovementType {
	DIRECTIONAL_INPUT,
	CLICK_AND_MOVE,
}

const INTERACTABLE_LAYER = 6

@export var health = 100
@export var movement_type: MovementType = MovementType.DIRECTIONAL_INPUT
@export var lock_to_screen = true
@export var top_speed = Vector2(450, 450)
@export var acceleration = Vector2(450, 450)
@export var deceleration = Vector2(600, 600)
@export var s_projectile_shooter: PackedScene
@export var interaction_radius = 80.0
@export var s_health_consumable: PackedScene

var velocity = Vector2.ZERO
var enemy_mask = 1 << 2
var enemy_group = "Enemy"
var screen_size
var interact_pressed = false
var health_consumable
var shooter
@onready var target = position


func _ready():
	_add_shooter()
	_init_health_consumable()
	screen_size = get_viewport_rect().size


func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
	if event.is_action_pressed("interact"):
		interact_pressed = true
	if event.is_action_pressed("consume_1"):
		if health_consumable != null:
			health_consumable.consume()


func _physics_process(delta):
	movement(delta)
	if interact_pressed:
		_try_interact()
		interact_pressed = false


func change_health(change):
	health += change
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("player_died")


func movement(delta):
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
	elif abs(velocity.y) > 0.001:
		if velocity.y < -0.001:
			velocity.y += min(deceleration.y * delta, abs(velocity.y))
		elif velocity.y > 0.001:
			velocity.y -= min(deceleration.y * delta, velocity.y)
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
	elif abs(velocity.x) > 0.001:
		if velocity.x < -0.001:
			velocity.x += min(deceleration.x * delta, abs(velocity.x))
		elif velocity.x > 0.001:
			velocity.x -= min(deceleration.x * delta, velocity.x)
		_update_velocity()


func _click_and_move_movement():
	velocity = position.direction_to(target) * top_speed
	if position.distance_to(target) < 5:
		velocity = Vector2.ZERO
	_update_velocity()


func _update_velocity():
	velocity.x = clamp(velocity.x, -top_speed.x, top_speed.x)
	velocity.y = clamp(velocity.y, -top_speed.y, top_speed.y)

	if lock_to_screen:
		if (velocity.x > 0 && position.x >= screen_size.x) || (velocity.x < 0 && position.x <= 0):
			velocity.x = 0
		if (velocity.y > 0 && position.y >= screen_size.y) || (velocity.y < 0 && position.y <= 0):
			velocity.y = 0
	linear_velocity = velocity


func _add_shooter():
	if s_projectile_shooter == null:
		return
	shooter = s_projectile_shooter.instantiate() as SProjectileShooter
	shooter.init([enemy_group], enemy_mask)
	add_child(shooter)


func _try_interact():
	var space_state = get_world_2d().direct_space_state
	var shape = CircleShape2D.new()
	shape.radius = interaction_radius
	var query = PhysicsShapeQueryParameters2D.new()
	query.shape = shape
	query.collision_mask = pow(2, INTERACTABLE_LAYER - 1)
	query.transform = transform
	var results = space_state.intersect_shape(query, 1)
	for result in results:
		result.collider.interact()


func _init_health_consumable():
	if s_health_consumable != null:
		health_consumable = s_health_consumable.instantiate() as SHealthConsumable
		add_child(health_consumable)
