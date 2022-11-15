class_name SPlayer
extends RigidBody2D

signal player_died

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var health = 100
export var top_speed = Vector2(350, 350)
export var acceleration = Vector2(450, 450)
export var deceleration = Vector2(600, 600)

var velocity = Vector2.ZERO


func change_health(change):
	health += change
	if health <= 0:
		emit_signal("player_died")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_movement(delta)


func _movement(delta):
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
	
func _update_velocity():
	velocity.x = clamp(velocity.x, -top_speed.x, top_speed.x)
	velocity.y = clamp(velocity.y, -top_speed.y, top_speed.y)

	linear_velocity = velocity
