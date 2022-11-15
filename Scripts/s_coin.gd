class_name SCoin
extends SCollectable

export var value = 5

func _collected():
	emit_signal("collected", value)
