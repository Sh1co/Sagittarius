extends CharacterBody2D

@export var movement_speed: float = 200.0
@export var target_search_rate = 1
var movement_target_position: Vector2 = Vector2(60.0, 180.0)
var counter = 0

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D


func _ready():
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	call_deferred("actor_setup")


func _process(delta):
	if $RigidBody2D == null:
		self.queue_free()
	counter += delta
	if counter >= target_search_rate:
		var level = get_parent() as SGamePlayLevel
		movement_target_position = level.player.position
		call_deferred("actor_setup")
		counter = 0


func actor_setup():
	await get_tree().physics_frame
	set_movement_target(movement_target_position)


func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target


func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed

	velocity = new_velocity
	move_and_slide()
