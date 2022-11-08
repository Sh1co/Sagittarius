extends Node2D

export(Array) var levels
var current_level_index = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	_load_level(current_level_index)


func _load_level(index):
	print("Loading Level " + str(index + 1))
	var level = levels[index].instance()
	level.position = Vector2.ZERO
	level.connect("level_complete", self, "_on_level_complete")
	add_child(level)


func _on_level_complete():
	current_level_index += 1
	_load_level(current_level_index % levels.size())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
