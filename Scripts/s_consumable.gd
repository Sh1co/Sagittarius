class_name SConsumable
extends Node

const CONSUMABLES_KEY = "consumable/"

@export var consumable_name = ""
@export var initCount = 5
@export var saveCount = false
var count = 0


func _ready():
	if !saveCount:
		count = initCount
	else:
		count = GBS.get_var(CONSUMABLES_KEY + consumable_name, initCount)


func consume():
	if count <= 0:
		print(consumable_name + " not consumed! " + str(count) + " remaining.")
		return false
	count -= 1
	if saveCount:
		GBS.set_var(CONSUMABLES_KEY + consumable_name, count)
	print(consumable_name + " consumed! " + str(count) + " remaining.")
	return true


func add(amount):
	count += amount
	if saveCount:
		GBS.set_var(CONSUMABLES_KEY + consumable_name, count)
