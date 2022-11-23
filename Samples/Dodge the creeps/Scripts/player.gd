extends SPlayer

var screen_size


func _ready():
	screen_size = get_viewport_rect().size


func _movement(delta):
	._movement(delta)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if velocity.length() > 0:
		$Sprite.play()
	else:
		$Sprite.stop()

	if velocity.x != 0:
		$Sprite.animation = "right"
		$Sprite.flip_v = false
		$Sprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$Sprite.animation = "up"
		$Sprite.flip_v = velocity.y > 0
