class_name SGamePlayLevel
extends SLevel

export(PackedScene) var s_player
export(PackedScene) var s_healthbar
export(PackedScene) var s_enemy_spawner
export(PackedScene) var s_coins_spawner
export(PackedScene) var s_coins_counter_ui

var player
var healthbar
var coins_counter_ui
var coins = 0


func _ready():
	_spawn_player()

	_add_health_bar()

	_add_coins_counter()

	_spawn_enemies()

	_spawn_coins()


func change_player_health(change):
	player.change_health(change)
	print("Player health changed by " + str(change))
	if healthbar != null:
		healthbar.health_changed(player.health)
		print("HealthBar updated!")


func _on_Button_pressed():
	level_complete()


func _on_Button2_pressed():
	change_player_health(-20)


func _spawn_enemies():
	var enemy_spawner = s_enemy_spawner.instance() as SEntitySpawner
	add_child(enemy_spawner)
	enemy_spawner.connect("entity_spawned", self, "_on_enemy_spawned")
	enemy_spawner.spawn()


func _spawn_coins():
	var coins_spawner = s_coins_spawner.instance() as SEntitySpawner
	add_child(coins_spawner)
	coins_spawner.connect("entity_spawned", self, "_on_collectable_spawned")
	coins_spawner.spawn()


func _on_enemy_spawned(enemy):
	enemy.connect("attacked_player", self, "change_player_health")


func _on_collectable_spawned(collectable):
	collectable.connect("collected", self, "_on_collectable_collected")


func _on_collectable_collected(value):
	coins += value
	coins_counter_ui.coins_updated(coins)
	print("Coins collected! You know have: " + str(coins))


func _spawn_player():
	player = s_player.instance() as SPlayer
	player.position = $StartPosition.position
	player.connect("player_died", self, "player_died")
	add_child(player)


func _add_health_bar():
	healthbar = s_healthbar.instance() as SHealthBar
	healthbar.init(player.health, player.health)
	add_child(healthbar)


func _add_coins_counter():
	coins_counter_ui = s_coins_counter_ui.instance() as SCoinsCounterUI
	add_child(coins_counter_ui)
