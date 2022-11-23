extends SEntitySpawner

export(PackedScene) var enemy


func _ready():
	$MobTimer.start()


func spawn():
	pass


func _on_MobTimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = enemy.instance()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.offset = randi()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	emit_signal("entity_spawned", mob)
	add_child(mob)
