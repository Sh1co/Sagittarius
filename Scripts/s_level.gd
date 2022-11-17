class_name SLevel
extends Node2D

signal level_complete

var coins_manager: SCoinsManager


func level_complete():
	print("Level Complete!")
	emit_signal("level_complete")
	self.queue_free()


func player_died():
	print("Player died, reseting level.")
	get_tree().reload_current_scene()
