extends SProjectileShooter

@export var max_hold = 1500
@export var speed_multiplier = 1.5

var press_start_time = 0.0
var speed = 0


func _input(event):
	_check_shooting(event)


func _check_shooting(event):
	if !$ShootingCooldown.is_stopped():
		return
	if event.is_action_pressed("shoot"):
		press_start_time = Time.get_ticks_msec()
	if event.is_action_released("shoot"):
		$ShootingCooldown.start()
		_shoot_projectile(get_parent().rotation)


func _shoot_projectile(direction):
	if !is_initialized:
		push_warning("Shooter not initialized. Make sure you call init on shooter!")
		return
	var projectile = s_projectile.instantiate() as SProjectile
	if add_parent_velocity:
		projectile.launch_velocity = velocity
	projectile.rotation += direction
	projectile.position = global_position
	projectile.collision_mask |= projectile_mask
	projectile.targets = targets
	var diff = Time.get_ticks_msec() - press_start_time
	press_start_time = Time.get_ticks_msec()
	diff = min(diff, max_hold)
	speed = -inverse_lerp(200, max_hold, diff + 300) * projectile.speed * speed_multiplier
	projectile.speed = speed
	get_parent().get_parent().add_child(projectile)
