extends Node

var save_data = {}


func _ready():
	_getsave_data()


func _exit_tree():
	save()


func _getsave_data():
	if not FileAccess.file_exists("user://gbs.save"):
		save()
	var save_file = FileAccess.open("user://gbs.save", FileAccess.READ)
	var test_json_conv = JSON.new()
	test_json_conv.parse(save_file.get_line())
	save_data = test_json_conv.get_data()
	save_file.close()


func save():
	var save_file = FileAccess.open("user://gbs.save", FileAccess.WRITE)
	save_file.store_line(JSON.new().stringify(save_data))
	save_file.close()


func set_var(key, value):
	save_data[key] = value


func get_var(key, default):
	if has_var(key):
		return save_data[key]
	return default


func has_var(key):
	return save_data.has(key)


func delete_var(key):
	return save_data.erase(key)


func delete_all():
	save_data.clear()
