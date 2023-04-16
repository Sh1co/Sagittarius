class_name SDialogueLevel
extends SLevel

@export var messages: Array[String]
@export var message_label_path: NodePath
@export var message_delay_time = 3.0

var msg_index = 0
@onready var tween = get_tree().create_tween()
@onready var message_label = get_node(message_label_path)


func _ready():
	show_next_msg()


func _input(event):
	if event.is_action_pressed("accept"):
		show_next_msg()


func show_next_msg():
	if msg_index >= messages.size():
		complete_level()
		return
	tween.kill()
	tween = get_tree().create_tween()
	show_msg(messages[msg_index])
	msg_index += 1


func show_msg(msg):
	message_label.text = msg
	tween.tween_property(message_label, "modulate:a", 0, 0)
	tween.tween_property(message_label, "modulate:a", 1, 1)
	tween.tween_interval(message_delay_time)
	tween.tween_property(message_label, "modulate:a", 0, 1)
	tween.tween_callback(show_next_msg.bind())
	tween.play()
