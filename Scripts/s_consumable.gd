class_name SConsumable
extends Node

const CONSUMABLES_KEY = "consumable/"

@export var consumable_name = ""
@export var init_count = 5
@export var save_count = false
var count = 0


func _ready():
	if !save_count:
		count = init_count
	else:
		count = GBS.get_var(CONSUMABLES_KEY + consumable_name, init_count)


func consume():
	if count <= 0:
		print(consumable_name + " not consumed! " + str(count) + " remaining.")
		return false
	count -= 1
	if save_count:
		GBS.set_var(CONSUMABLES_KEY + consumable_name, count)
	print(consumable_name + " consumed! " + str(count) + " remaining.")
	return true


func add(amount):
	count += amount
	if save_count:
		GBS.set_var(CONSUMABLES_KEY + consumable_name, count)
