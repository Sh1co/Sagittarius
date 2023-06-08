extends Button


signal equip_item(item)


var item: PackedScene


func init(item_ps):
	item = item_ps
	text = _fix_name(item.resource_path)


func _fix_name(path:String):
	var f1 = false
	var name = ""
	for i in range(path.length()-1,-1,-1):
		if path[i]=='/':
			break
		if f1:
			name = path[i] + name
		if path[i] == '.':
			f1 = true
	return name

func _on_pressed():
	emit_signal("equip_item", item)
