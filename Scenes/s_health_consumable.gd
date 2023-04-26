class_name SHealthConsumable
extends SConsumable

@export var health_regained = 20


func consume():
	if super.consume():
		var player = get_parent() as SPlayer
		player.change_health(health_regained)
