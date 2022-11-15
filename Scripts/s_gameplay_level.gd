class_name SGamePlayLevel
extends SLevel

export(PackedScene) var s_player
export(PackedScene) var s_healthbar
export(PackedScene) var s_enemy_spawner

var player
var healthbar


func _ready():
	_spawn_player()

	_add_health_bar()

	_spawn_enemies()


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


func _spawn_player():
	player = s_player.instance() as SPlayer
	player.position = $StartPosition.position
	player.connect("player_died", self, "player_died")
	add_child(player)


func _add_health_bar():
	healthbar = s_healthbar.instance() as SHealthBar
	healthbar.init(player.health, player.health)
	add_child(healthbar)
