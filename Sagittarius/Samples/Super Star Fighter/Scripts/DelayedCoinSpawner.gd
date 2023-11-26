extends SFixedEntitySpawner

var i = 0


func spawn():
	_spawn_with_delay()


func _spawn_with_delay():
	if i >= entities.size():
		return
	var entity = entities[i].instantiate()
	entity.position = get_node(entity_positions[i % entity_positions.size()]).position
	emit_signal("entity_spawned", entity)
	add_child(entity)
	i += 1
	$SpawnDelay.start()
