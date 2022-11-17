class_name SGame
extends Node2D

export(Array) var levels
export(PackedScene) var s_coins_manager
var current_level_index = 0

var coins_manager: SCoinsManager


func _ready():
	_add_coins_manager()
	_load_level(current_level_index)


func _load_level(index):
	print("Loading Level " + str(index + 1))
	var level = levels[index].instance() as SLevel
	level.position = Vector2.ZERO
	level.connect("level_complete", self, "_on_level_complete")
	level.coins_manager = coins_manager
	add_child(level)


func _on_level_complete():
	current_level_index += 1
	_load_level(current_level_index % levels.size())


func _add_coins_manager():
	if s_coins_manager == null:
		push_warning("Coins manager not added to main game node!")
		return
	coins_manager = s_coins_manager.instance() as SCoinsManager
	add_child(coins_manager)
