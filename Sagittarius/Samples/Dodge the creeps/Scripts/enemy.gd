extends SEnemy

@export var movement_speed = 100


func _ready():
	$Sprite2D.play()


func _movement(delta):
	position += Vector2.RIGHT.rotated(rotation) * movement_speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
