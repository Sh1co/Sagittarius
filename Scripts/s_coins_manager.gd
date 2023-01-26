class_name SCoinsManager
extends Node

signal coins_update(new_value)

var coins = 0
const COINS_KEY = "coins"


func _ready():
	get_coins()


func get_coins():
	coins = int(GBS.get_var(COINS_KEY, coins))
	return coins


func _set_coins(value):
	GBS.set_var(COINS_KEY, coins)
	GBS.save()


func change_coins(change):
	coins += change
	_set_coins(coins)
	emit_signal("coins_update", coins)
