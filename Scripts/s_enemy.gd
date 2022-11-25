class_name SEnemy
extends KinematicBody2D

export var health = 100
export var damage = 20
export(PackedScene) var s_projectile_shooter

var speed = 400
var angular_speed = PI
var player_mask = 1 << 1
var player_group = "Player"


func _ready():
	_add_shooter()


func _process(delta):
	_movement(delta)


func change_health(change):
	health += change
	print("Enemy health reduced by " + str(change))
	if health <= 0:
		queue_free()


func _movement(delta):
	rotation += angular_speed * delta
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta


func _damage_player():
	emit_signal("attacked_player", -damage)


func _on_SEnemy_body_entered(body):
	print("Coll!!")
	if body.is_in_group("Player"):
		body.change_health(-damage)


func _add_shooter():
	if s_projectile_shooter == null:
		return
	var shooter = s_projectile_shooter.instance() as SProjectileShooter
	shooter.init([player_group], player_mask)
	add_child(shooter)
