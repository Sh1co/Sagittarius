class_name SProjectile
extends Area2D

@export var speed = 600
@export var targets: Array
@export var damage = 20

var launch_velocity = Vector2.ZERO


func _physics_process(delta):
	_movement(delta)


func _movement(delta):
	var velocity = Vector2.UP.rotated(rotation) * speed + launch_velocity
	position += velocity * delta


func _on_SProjectile_body_entered(body):
	for target in targets:
		if body.is_in_group(target):
			body.change_health(-damage)
			break
	queue_free()
