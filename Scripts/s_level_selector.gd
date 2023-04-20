class_name SLevelSelector
extends SLevel

signal go_to_level(id)

@export var level_button: PackedScene

var GAME_PROGRESS_KEY = "game_progress"

var _levels: Array[String]
var _lock_unfinished = false

func init(levels: Array[String], lock_unfinished: bool):
	_levels = levels
	_lock_unfinished = lock_unfinished
	_create_level_grid()


func _create_level_grid():
	for ind in _levels.size():
		var lvl_btn = level_button.instantiate() as SLevelButton
		lvl_btn.init(_levels[ind], ind)
		lvl_btn.level_selected.connect(_on_level_selected.bind())
		if _lock_unfinished and ind > GBS.get_var(GAME_PROGRESS_KEY, 0):
			lvl_btn.disabled = true
		$Control/LevelGrid.add_child(lvl_btn)


func _on_level_selected(id):
	emit_signal("go_to_level", id)
	print(id)
	queue_free()


func _on_back_pressed():
	emit_signal("go_to_level", -1)
	queue_free()
