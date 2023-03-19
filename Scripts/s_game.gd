class_name SGame
extends Node2D

@export var s_main_menu: PackedScene
@export var levels: Array[PackedScene]
@export var s_coins_manager: PackedScene
var current_level_index = -1

var coins_manager: SCoinsManager


func _ready():
	_add_coins_manager()
	_load_main_menu()


func _load_level(index):
	print("Loading Level " + str(index + 1))
	var level = levels[index].instantiate() as SLevel
	level.position = Vector2.ZERO
	level.level_completed.connect(_on_level_complete.bind())
	level.level_failed.connect(_reload_current_level.bind())
	level.coins_manager = coins_manager
	call_deferred("add_child", level)


func _load_main_menu():
	var main_menu = s_main_menu.instantiate()
	main_menu.level_completed.connect(_on_level_complete.bind())
	main_menu.coins_manager = coins_manager
	call_deferred("add_child", main_menu)


func _reload_current_level():
	_load_level(current_level_index)


func _on_level_complete():
	current_level_index += 1
	if current_level_index >= levels.size():
		current_level_index = -1
		_load_main_menu()
		return
	_load_level(current_level_index)


func _on_levels_start():
	_load_level(current_level_index)


func _add_coins_manager():
	if s_coins_manager == null:
		push_warning("Coins manager not added to main game node!")
		return
	coins_manager = s_coins_manager.instantiate() as SCoinsManager
	add_child(coins_manager)
