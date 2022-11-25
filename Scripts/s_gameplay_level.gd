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


func _ready():
	_spawn_player()

	_add_health_bar()

	_add_coins_counter()

	_spawn_enemies()

	_spawn_coins()


func change_player_health(change):
	player.change_health(change)
	print("Player health changed by " + str(change))


func _on_Button_pressed():
	level_complete()


func _on_Button2_pressed():
	change_player_health(-20)


func _on_Button3_pressed():
	print("Reseting Coins!")
	if coins_manager != null:
		coins_manager.change_coins(-coins_manager.get_coins())


func _spawn_enemies():
	if s_enemy_spawner == null:
		return
	var enemy_spawner = s_enemy_spawner.instance() as SEntitySpawner
	add_child(enemy_spawner)
	enemy_spawner.spawn()


func _spawn_coins():
	if s_coins_spawner == null:
		return
	var coins_spawner = s_coins_spawner.instance() as SEntitySpawner
	add_child(coins_spawner)
	coins_spawner.connect("entity_spawned", self, "_on_collectable_spawned")
	coins_spawner.spawn()


func _on_collectable_spawned(collectable):
	collectable.connect("collected", self, "_on_collectable_collected")


func _on_collectable_collected(value):
	if coins_manager != null:
		coins_manager.change_coins(value)
		print("Coins collected! You know have: " + str(coins_manager.get_coins()))
	else:
		print("Coins collected! But coins manager isn't added to the game!")


func _spawn_player():
	if s_player == null:
		return
	player = s_player.instance() as SPlayer
	player.position = $StartPosition.position
	player.connect("player_died", self, "player_died")
	add_child(player)


func _add_health_bar():
	if s_healthbar == null:
		return
	healthbar = s_healthbar.instance() as SHealthBar
	healthbar.init(player.health, player.health)
	player.connect("health_changed", healthbar, "health_changed")
	add_child(healthbar)


func _add_coins_counter():
	if s_coins_counter_ui == null:
		return
	coins_counter_ui = s_coins_counter_ui.instance() as SCoinsCounterUI
	if coins_manager != null:
		coins_manager.connect("coins_update", coins_counter_ui, "coins_updated")
		coins_counter_ui.coins_updated(coins_manager.get_coins())
	else:
		print("Coins manager was not added to game!")
	add_child(coins_counter_ui)
