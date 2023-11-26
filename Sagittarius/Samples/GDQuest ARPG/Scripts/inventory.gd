extends Control

@export var items: Array[PackedScene]
@export var inventory_item_button: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	_build_inventory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_released("inventory"):
		visible = !visible


func _build_inventory():
	for item in items:
		var item_btn = inventory_item_button.instantiate()
		item_btn.init(item)
		item_btn.connect("equip_item", _equip_item.bind())
		$Scroll/VBoxContainer.add_child(item_btn)


func _equip_item(item):
	print("Equiping item!")
	var level = get_parent().get_parent() as SGamePlayLevel
	var player = level.player as SPlayer
	player.shooter.s_projectile = item
