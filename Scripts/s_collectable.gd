class_name SCollectable
extends Node2D

signal collected(value)

export var value = 5


func _process(delta):
	_movement(delta)


func _movement(delta):
	pass


func _on_SCollectable_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("collected", value)
		queue_free()
