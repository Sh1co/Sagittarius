class_name SEnemy
extends Node2D

signal attacked_player(attack_damage)

export var damage = 20

var speed = 400
var angular_speed = PI


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_movement(delta)


func _movement(delta):
	rotation += angular_speed * delta
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta


func _damage_player():
	emit_signal("attacked_player", -damage)


func _on_SEnemy_body_entered(body):
	if body.is_in_group("Player"):
		_damage_player()
