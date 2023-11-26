extends SProjectileShooter


func _input(event):
	_check_shooting(event)


func _check_shooting(event):
	if !$ShootingCooldown.is_stopped():
		return
	if event.is_action_pressed("shoot_up"):
		$ShootingCooldown.start()
		_shoot_projectile(0)
	if event.is_action_pressed("shoot_down"):
		$ShootingCooldown.start()
		_shoot_projectile(PI)
	if event.is_action_pressed("shoot_right"):
		$ShootingCooldown.start()
		_shoot_projectile(PI / 2)
	if event.is_action_pressed("shoot_left"):
		$ShootingCooldown.start()
		_shoot_projectile(-PI / 2)
