extends SProjectileShooter

@export var ignore_delay = 500

var press_start_time = 0.0


func _input(event):
	_check_shooting(event)


func _check_shooting(event):
	if !$ShootingCooldown.is_stopped():
		return
	if event.is_action_pressed("shoot"):
		press_start_time = Time.get_ticks_msec()
	if event.is_action_released("shoot"):
		var diff = Time.get_ticks_msec() - press_start_time
		if diff <= ignore_delay:
			$ShootingCooldown.start()
			_shoot_projectile(get_parent().rotation)
