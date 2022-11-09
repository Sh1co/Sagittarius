class_name SLevel
extends Node2D

signal level_complete

export(PackedScene) var s_player
export(PackedScene) var s_healthbar
export(PackedScene) var s_enemy_spawner

var player
var healthbar


func _ready():
	# Add Player to level
	player = s_player.instance() as SPlayer
	player.position = $StartPosition.position
	player.connect("player_died", self, "player_died")
	add_child(player)

	# Add healthbar to level
	healthbar = s_healthbar.instance() as SHealthBar
	healthbar.init(player.health, player.health)
	add_child(healthbar)

	_spawn_enemies()


func level_complete():
	print("Level Complete!")
	emit_signal("level_complete")
	self.queue_free()


func player_died():
	print("Player died, reseting level.")
	get_tree().reload_current_scene()


func change_player_health(change):
	print("Player health changed by " + str(change))
	player.change_health(change)
	healthbar.health_changed(player.health)


func _on_Button_pressed():
	level_complete()


func _on_Button2_pressed():
	change_player_health(-20)


func _spawn_enemies():
	var enemy_spawner = s_enemy_spawner.instance() as SEnemySpawner
	add_child(enemy_spawner)
	enemy_spawner.connect("enemy_spawned", self, "_on_enemy_spawned")
	enemy_spawner.spawn()


func _on_enemy_spawned(enemy):
	enemy.connect("attacked_player", self, "change_player_health")
