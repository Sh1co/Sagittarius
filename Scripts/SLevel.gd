extends Node2D

signal level_complete

export(PackedScene) var s_player


func _ready():
	var player = s_player.instance()
	player.position = $StartPosition.position
	add_child(player)



func level_complete():
	print("Level Complete!")
	emit_signal("level_complete")
	self.queue_free()


func _on_Button_pressed():
	level_complete()
