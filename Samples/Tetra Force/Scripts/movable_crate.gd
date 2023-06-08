extends RigidBody2D

@export var touch_time = 1.0
@export var movement_size = 20
@export var movement_time = 1

var touching_player = false
var player_pos = Vector2.ZERO
var touch_counter = 0.0
var moved = false



func _ready():
	pass 



func _process(delta):
	if !touching_player || moved:
		touch_counter = 0.0
		return
	print(touch_counter)
	if Input.is_action_pressed("move_up") && player_pos.y > position.y:
		touch_counter += delta
	elif Input.is_action_pressed("move_down") && player_pos.y < position.y:
		touch_counter += delta
	elif Input.is_action_pressed("move_left") && player_pos.x > position.x:
		touch_counter += delta
	elif Input.is_action_pressed("move_right")&& player_pos.x < position.x:
		touch_counter += delta
	else:
		touch_counter = 0.0
	
	if touch_counter >= touch_time:
		moved = true
		var _tween = get_tree().create_tween()
		if Input.is_action_pressed("move_up"):
			_tween.tween_property(self, "position:y", position.y-movement_size, movement_time)
		elif Input.is_action_pressed("move_down"):
			_tween.tween_property(self, "position:y", position.y+movement_size, movement_time)
		elif Input.is_action_pressed("move_left"):
			_tween.tween_property(self, "position:x", position.x-movement_size, movement_time)
		elif Input.is_action_pressed("move_right"):
			_tween.tween_property(self, "position:x", position.x+movement_size, movement_time)
		_tween.play()
		
	


func _on_body_entered(body):
	if body.is_in_group("Player"):
		touching_player = true
		player_pos = body.position


func _on_body_exited(body):
	if body.is_in_group("Player"):
		touching_player = false
