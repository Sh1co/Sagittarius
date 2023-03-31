class_name SLevelSelector
extends SLevel

signal go_to_level(id)

@export var level_button: PackedScene

var _levels: Array[String]


func init(levels):
	_levels = levels
	_create_Level_Grid()


func _create_Level_Grid():
	for ind in _levels.size():
		var lvl_btn = level_button.instantiate() as SLevelButton
		lvl_btn.init(_levels[ind], ind)
		lvl_btn.level_selected.connect(_on_level_selected.bind())
		$Control/LevelGrid.add_child(lvl_btn)


func _on_level_selected(id):
	emit_signal("go_to_level", id)
	print(id)
