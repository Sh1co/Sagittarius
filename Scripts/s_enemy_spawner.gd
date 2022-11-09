class_name SEnemySpawner
extends Node2D

signal enemy_spawned(enemy)

export(Array) var s_enemies
export(Array) var enemy_positions


func spawn():
	for i in s_enemies.size():
		var enemy = s_enemies[i].instance()
		enemy.position = get_node(enemy_positions[i]).position
		emit_signal("enemy_spawned", enemy)
		add_child(enemy)
