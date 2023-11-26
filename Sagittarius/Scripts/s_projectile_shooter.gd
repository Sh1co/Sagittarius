class_name SProjectileShooter
extends Node2D

@export var s_projectile: PackedScene

var targets = []
var projectile_mask
var add_parent_velocity
var velocity = Vector2.ZERO
var is_initialized = false
@onready var past_position = global_position


func _physics_process(delta):
	_get_velocity(delta)


func init(projectile_targets, projectile_physics_mask, add_velocity = true):
	targets = projectile_targets
	projectile_mask = projectile_physics_mask
	add_parent_velocity = add_velocity
	is_initialized = true


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
	get_parent().get_parent().add_child(projectile)


func _get_velocity(delta):
	velocity = (global_position - past_position) / delta
	past_position = global_position
