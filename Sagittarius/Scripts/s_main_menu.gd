class_name SMainMenu
extends SLevel

signal level_selector


func _on_Start_pressed():
	complete_level()


func _on_all_levels_pressed():
	emit_signal("level_selector")
	queue_free()
