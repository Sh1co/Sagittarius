class_name SEnemy
extends KinematicBody2D

export var health = 100
export var damage = 20

var speed = 400
var angular_speed = PI


func change_health(change):
	health += change
	print("Enemy health reduced by " + str(change))
	if health <= 0:
		queue_free()


func _process(delta):
	_movement(delta)


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
