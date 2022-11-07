extends Node

signal level_complete

export(PackedScene) var s_player


func _ready():
#	var player = s_player.instance()
#	player.position = $StartPosition.position
#	add_child(player)
	pass  # Replace with function body.


func _on_Goal_body_entered(body):
	print("Collision!")
	if body.is_in_group("Player"):
		emit_signal("level_complete")
		print("Level Complete!")
