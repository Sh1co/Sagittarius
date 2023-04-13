class_name SGamePlayLevel
extends SLevel

@export var level_name: String
@export var s_player: PackedScene
@export var s_healthbar: PackedScene
@export var s_enemy_spawner: PackedScene
@export var s_coins_spawner: PackedScene
@export var s_coins_counter_ui: PackedScene
@export var level_annoucement = false
@export var level_title_scene: NodePath

var player
var healthbar
var coins_counter_ui


func _ready():
	_spawn_player()

	_add_health_bar()

	_add_coins_counter()

	_spawn_enemies()

	_spawn_coins()

	_announce_level()


func change_player_health(change):
	player.change_health(change)
	print("Player health changed by " + str(change))


func _on_Button_pressed():
	complete_level()


func _on_Button2_pressed():
	change_player_health(-20)


func _on_Button3_pressed():
	print("Reseting Coins!")
	if coins_manager != null:
		coins_manager.change_coins(-coins_manager.get_coins())


func _spawn_enemies():
	if s_enemy_spawner == null:
		return
	var enemy_spawner = s_enemy_spawner.instantiate() as SEntitySpawner
	add_child(enemy_spawner)
	enemy_spawner.spawn()


func _spawn_coins():
	if s_coins_spawner == null:
		return
	var coins_spawner = s_coins_spawner.instantiate() as SEntitySpawner
	add_child(coins_spawner)
	coins_spawner.connect("entity_spawned", Callable(self, "_on_collectable_spawned"))
	coins_spawner.spawn()


func _on_collectable_spawned(collectable):
	collectable.connect("collected", Callable(self, "_on_collectable_collected"))


func _on_collectable_collected(value):
	if coins_manager != null:
		coins_manager.change_coins(value)
		print("Coins collected! You now have: " + str(coins_manager.get_coins()))
	else:
		print("Coins collected! But coins manager isn't added to the game!")


func _spawn_player():
	if s_player == null:
		return
	player = s_player.instantiate() as SPlayer
	player.position = $StartPosition.position
	player.connect("player_died", Callable(self, "player_died"))
	add_child(player)


func _add_health_bar():
	if s_healthbar == null:
		return
	healthbar = s_healthbar.instantiate() as SHealthBar
	healthbar.init(player.health, player.health)
	player.connect("health_changed", Callable(healthbar, "health_changed"))
	add_child(healthbar)


func _add_coins_counter():
	if s_coins_counter_ui == null:
		return
	coins_counter_ui = s_coins_counter_ui.instantiate() as SCoinsCounterUI
	if coins_manager != null:
		coins_manager.connect("coins_update", Callable(coins_counter_ui, "coins_updated"))
		coins_counter_ui.coins_updated(coins_manager.get_coins())
	else:
		print("Coins manager was not added to game!")
	add_child(coins_counter_ui)


func _announce_level():
	if level_title_scene == null:
		return
	var tween = get_tree().create_tween()
	var level_title = get_node(level_title_scene)
	if level_annoucement:
		tween.tween_property(level_title, "modulate:a", 0, 0)
		tween.tween_property(level_title, "modulate:a", 1, 1)
		tween.tween_property(level_title, "modulate:a", 0, 1)
	tween.tween_callback(level_title.queue_free)
