extends RigidBody2D

@export var touch_time = 1.0
@export var level_index = 1

var touching_player = false
var player_pos = Vector2.ZERO
var touch_counter = 0.0


func _ready():
	pass


func _process(delta):
	if !touching_player:
		touch_counter = 0.0
		return
	print(touch_counter)
	if Input.is_action_pressed("move_up") && player_pos.y > position.y:
		touch_counter += delta
	elif Input.is_action_pressed("move_down") && player_pos.y < position.y:
		touch_counter += delta
	elif Input.is_action_pressed("move_left") && player_pos.x > position.x:
		touch_counter += delta
	elif Input.is_action_pressed("move_right") && player_pos.x < position.x:
		touch_counter += delta
	else:
		touch_counter = 0.0

	if touch_counter >= touch_time:
		print("lol")
		var level = get_parent() as SGamePlayLevel
		level.move_to_level(level_index)


func _on_body_entered(body):
	print("contact!")
	if body.is_in_group("Player"):
		print("With player!")
		touching_player = true
		player_pos = body.position


func _on_body_exited(body):
	if body.is_in_group("Player"):
		touching_player = false
