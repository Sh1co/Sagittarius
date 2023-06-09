extends SProjectileShooter


func _input(event):
	_check_shooting(event)


func _check_shooting(event):
	if !$ShootingCooldown.is_stopped():
		return
	if event.is_action_pressed("shoot"):
		$ShootingCooldown.start()
		_shoot_projectile(0)


func _shoot_projectile(direction):
	if !is_initialized:
		push_warning("Shooter not initialized. Make sure you call init on shooter!")
		return
	var projectile = s_projectile.instantiate() as SProjectile
	projectile.rotation += direction
#	projectile.position = global_position
	projectile.collision_mask |= projectile_mask
	projectile.targets = targets
	get_parent().add_child(projectile)
