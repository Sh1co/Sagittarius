class_name SLevelSelector
extends SLevel

@export var levels: Array[String]
@export var level_button: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	_create_Level_Grid()


func _create_Level_Grid():
	for level in levels:
		var lvl_btn = level_button.instantiate() as SLevelButton
		lvl_btn.init(level, 1)
		$Control/LevelGrid.add_child(lvl_btn)
