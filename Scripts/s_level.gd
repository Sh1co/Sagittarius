class_name SLevel
extends Node2D

signal level_complete
signal level_failed

var coins_manager: SCoinsManager


func level_complete():
	print("Level Complete!")
	emit_signal("level_complete")
	self.queue_free()

func level_failed():
	print("Level Failed!")
	emit_signal("level_failed")
	self.queue_free()

func player_died():
	print("Player died, reseting level.")
	level_failed()
