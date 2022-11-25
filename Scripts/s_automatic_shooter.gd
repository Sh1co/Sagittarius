extends SProjectileShooter


func _on_ShootingInterval_timeout():
	_shoot_projectiles()


func _shoot_projectiles():
	_shoot_projectile(0)
	_shoot_projectile(PI)
	_shoot_projectile(PI / 2)
	_shoot_projectile(-PI / 2)
