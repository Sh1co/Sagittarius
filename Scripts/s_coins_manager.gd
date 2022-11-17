class_name SCoinsManager
extends Node

signal coins_update(new_value)

var coins = 0


func _ready():
	get_coins()


func get_coins():
	var coins_data = File.new()
	if not coins_data.file_exists("user://coins.save"):
		set_coins(coins)
	coins_data.open("user://coins.save", File.READ)
	var str_value = coins_data.get_line()
	coins_data.close()
	coins = int(str_value)
	return coins


func set_coins(value):
	var coins_data = File.new()
	coins_data.open("user://coins.save", File.WRITE)
	coins_data.store_line(str(value))
	coins_data.close()


func change_coins(change):
	coins += change
	set_coins(coins)
	emit_signal("coins_update", coins)
