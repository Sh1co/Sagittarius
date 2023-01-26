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
	var save_file = File.new()
	save_file.open("user://gbs.save", File.WRITE)
	save_file.store_line(to_json(save_data))
	save_file.close()


func set_var(key, value):
	save_data[key] = value


func get_var(key, default):
	if has_var(key):
		return save_data[key]
	else:
		return default


func has_var(key):
	return save_data.has(key)


func delete_var(key):
	return save_data.erase(key)


func delete_all():
	save_data.clear()
