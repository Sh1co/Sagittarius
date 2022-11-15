class_name SFixedEntitySpawner
extends SEntitySpawner

export(Array) var entities
export(Array) var entity_positions


func spawn():
	for i in entities.size():
		var entity = entities[i].instance()
		entity.position = get_node(entity_positions[i % entity_positions.size()]).position
		emit_signal("entity_spawned", entity)
		add_child(entity)
