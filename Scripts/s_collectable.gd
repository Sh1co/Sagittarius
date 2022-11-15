class_name SCollectable
extends Node2D

signal collected(value)


func _process(delta):
	_movement(delta)


func _movement(delta):
	pass


func _collected():
	pass


func _on_SCollectable_body_entered(body):
	if body.is_in_group("Player"):
		_collected()
		queue_free()
