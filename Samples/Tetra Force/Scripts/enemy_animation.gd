extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	play()


func _process(_delta):
	var player_velocity: Vector2 = $"..".velocity

	if player_velocity.length() > 0:
		animation = "run"
		flip_h = player_velocity.x < 0
	else:
		animation = "idle"
