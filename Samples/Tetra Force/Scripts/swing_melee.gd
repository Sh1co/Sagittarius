extends SProjectile

@onready var past_position = global_position


func _ready():
	_fix_rotation()
	var _tween = get_tree().create_tween()
	_tween.tween_property(
		self, "rotation", deg_to_rad(180) * (-1 if $"../AnimatedSprite2D".flip_h else 1), 0.1
	)
	_tween.tween_callback(self.queue_free.bind())
	_tween.play()


func movement(delta):
	_fix_rotation()
	pass


func _fix_rotation():
	_change_direction($"../AnimatedSprite2D".flip_h)


func _change_direction(right):
	if right:
#		$WeaponAnimeSword.set_flip_h( true )
		scale = Vector2(-1, scale.y)
		position = Vector2(-5, 4)
	else:
#		$WeaponAnimeSword.set_flip_h( false )
		scale = Vector2(1, scale.y)
		position = Vector2(12, 4)
