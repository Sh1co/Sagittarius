extends SPlayer

var screen_size


func _ready():
	screen_size = get_viewport_rect().size


func _movement(delta):
	super._movement(delta)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if velocity.length() > 0:
		$Sprite2D.play()
	else:
		$Sprite2D.stop()

	if velocity.x != 0:
		$Sprite2D.animation = "right"
		$Sprite2D.flip_v = false
		$Sprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$Sprite2D.animation = "up"
		$Sprite2D.flip_v = velocity.y > 0
