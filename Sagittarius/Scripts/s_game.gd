class_name SGame
extends Node2D

const LEVEL_INDEX_KEY = "level_index"
const GAME_PROGRESS_KEY = "game_progress"

@export var s_main_menu: PackedScene
@export var s_level_selector: PackedScene
@export var levels: Array[PackedScene]
@export var s_coins_manager: PackedScene
@export var save_level_progress = false
@export var procedural_generated = false

var current_level_index = -1
var coins_manager: SCoinsManager


func _ready():
	if procedural_generated:
		save_level_progress = false
	if save_level_progress:
		current_level_index = GBS.get_var(LEVEL_INDEX_KEY, 0) - 1
	_add_coins_manager()
	_load_main_menu()


func _load_level(index):
	print("Loading Level " + str(index + 1))
	var level = levels[index].instantiate() as SLevel
	level.position = Vector2.ZERO
	level.level_completed.connect(_on_level_complete.bind())
	level.level_failed.connect(_reload_current_level.bind())
	level.go_to_level.connect(_go_to_level.bind())
	if procedural_generated:
		level.game_complete.connect(_procedural_game_compelete.bind())
		level.generate()
	level.coins_manager = coins_manager
	call_deferred("add_child", level)


func _load_main_menu():
	if s_main_menu == null:
		_on_level_complete()
		return
	var main_menu = s_main_menu.instantiate() as SMainMenu
	main_menu.level_completed.connect(_on_level_complete.bind())
	main_menu.level_selector.connect(_load_level_selector.bind())
	main_menu.coins_manager = coins_manager
	call_deferred("add_child", main_menu)


func _reload_current_level():
	_load_level(current_level_index)


func _on_level_complete():
	current_level_index += 1
	if save_level_progress:
		GBS.set_var(LEVEL_INDEX_KEY, current_level_index)
		GBS.set_var(GAME_PROGRESS_KEY, max(current_level_index, GBS.get_var(GAME_PROGRESS_KEY, 0)))
	if current_level_index >= levels.size():
		if !procedural_generated:
			current_level_index = -1
			_load_main_menu()
			return
		current_level_index = 0
	_load_level(current_level_index)


func _procedural_game_compelete():
	current_level_index = -1
	_load_main_menu()


func _on_levels_start():
	_load_level(current_level_index)


func _load_level_selector():
	if s_level_selector == null:
		_load_main_menu()
		return
	var level_selector = s_level_selector.instantiate() as SLevelSelector
	level_selector.init(_get_names(levels), save_level_progress)
	level_selector.go_to_level.connect(_go_to_level.bind())
	call_deferred("add_child", level_selector)


func _go_to_level(index):
	current_level_index = index
	if index == -1:
		_load_main_menu()
		return
	if save_level_progress:
		GBS.set_var(LEVEL_INDEX_KEY, current_level_index)
		GBS.set_var(GAME_PROGRESS_KEY, max(current_level_index, GBS.get_var(GAME_PROGRESS_KEY, 0)))
	_load_level(index)


func _add_coins_manager():
	if s_coins_manager == null:
		push_warning("Coins manager not added to main game node!")
		return
	coins_manager = s_coins_manager.instantiate() as SCoinsManager
	add_child(coins_manager)


func _get_names(levels):
	var level_names = [] as Array[String]
	for level in levels:
		level_names.append(level.resource_path.get_file())
	return level_names
