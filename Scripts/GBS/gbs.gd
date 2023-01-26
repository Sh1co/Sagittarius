extends Node

var save_data = {}


func _ready():
	_getsave_data()


func _getsave_data():
	var save_file = File.new()
	if not save_file.file_exists("user://gbs.save"):
		save()
	save_file.open("user://gbs.save", File.READ)
	save_data = parse_json(save_file.get_line())
	save_file.close()


func save():
	pass


func set_var(key, value):
	pass


func get_var(key, default):
	pass


func has_var(key):
	pass


func delete_var(key):
	pass


func delete_all():
	pass
