class_name SProjectile
extends RigidBody2D

export var speed = 600
export(Array) var targets
export var damage = 20

var launch_velocity = Vector2.ZERO


func _integrate_forces(state):
	_movement(state)


func _movement(state):
	state.linear_velocity = Vector2.UP.rotated(rotation) * speed + launch_velocity


func _on_SProjectile_body_entered(body):
	for target in targets:
		if body.is_in_group(target):
			body.change_health(-damage)
			break
	queue_free()
