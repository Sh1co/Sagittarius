class_name SLevelButton
extends Button

signal level_selected(id)

var _level_id: int


func init(level_name: String, level_id: int):
	text = level_name
	_level_id = level_id


func _on_pressed():
	emit_signal("level_selected", _level_id)
