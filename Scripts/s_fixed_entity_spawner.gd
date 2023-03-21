class_name SFixedEntitySpawner
extends SEntitySpawner

@export var entities: Array
@export var entity_positions: Array


func spawn():
	for i in entities.size():
		var entity = entities[i].instantiate()
		entity.position = get_node(entity_positions[i % entity_positions.size()]).position
		emit_signal("entity_spawned", entity)
		add_child(entity)
