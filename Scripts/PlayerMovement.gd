extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var top_speed = Vector2(250, 250)
export var acceleration = Vector2(450, 450)
export var deceleration = Vector2(600, 600)

var velocity = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("move_up"):
		velocity.y -= acceleration.y * delta
		if velocity.y > 0:
			velocity.y -= deceleration.y * delta
	elif Input.is_action_pressed("move_down"):
		velocity.y += acceleration.y * delta
		if velocity.y < 0:
			velocity.y += deceleration.y * delta
	else:
		velocity.y += deceleration.x * delta * (1 if velocity.y < 0 else -1)

	if Input.is_action_pressed("move_left"):
		velocity.x -= acceleration.x * delta
		if velocity.x > 0:
			velocity.x -= deceleration.x * delta
	elif Input.is_action_pressed("move_right"):
		velocity.x += acceleration.x * delta
		if velocity.x < 0:
			velocity.x += deceleration.x * delta
	else:
		velocity.x += deceleration.x * delta * (1 if velocity.x < 0 else -1)

	velocity.x = clamp(velocity.x, -top_speed.x, top_speed.x)
	velocity.y = clamp(velocity.y, -top_speed.y, top_speed.y)

	position += velocity * delta
