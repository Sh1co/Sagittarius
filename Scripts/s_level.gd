class_name SLevel
extends Node2D

signal level_completed
signal level_failed
signal go_to_level(id)

@export var level_name: String

var coins_manager: SCoinsManager


func complete_level():
	print("Level Complete!")
	emit_signal("level_completed")
	self.queue_free()


func fail_level():
	print("Level Failed!")
	emit_signal("level_failed")
	self.queue_free()


func player_died():
	print("Player died, reseting level.")
	fail_level()
