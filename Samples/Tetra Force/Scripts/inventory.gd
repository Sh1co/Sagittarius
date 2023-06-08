extends Control

@export var items: Array[PackedScene]
@export var inventory_item_button: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	_build_inventory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("inventory"):
		visible = !visible


func _build_inventory():
	for item in items:
		var itemBtn = inventory_item_button.instantiate()
		itemBtn.init(item)
		itemBtn.connect("equip_item", _equip_item.bind())
		$Scroll/VBoxContainer.add_child(itemBtn)


func _equip_item(item):
	print("Equiping item!")
	var level = get_parent().get_parent() as SGamePlayLevel
	var player = level.player as SPlayer
	player.shooter.s_projectile = item
	pass
