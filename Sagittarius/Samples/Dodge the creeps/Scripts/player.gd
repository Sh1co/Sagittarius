extends SPlayer


func movement(delta):
	super.movement(delta)

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
