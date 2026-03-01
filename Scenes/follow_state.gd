class_name FollowState
extends State

@onready var enemy: CharacterBody2D = $"../.."
@onready var player_follow: Area2D = $"../../PlayerFollow"
@onready var follow_time: Timer = $"../../FollowTime"


func enter():
	print("Entering Follow State")
	follow_time.start()
	
func exit():
	pass
	
func update(delta: float):
	var direction = global.player_position - enemy.position
	
	enemy.velocity = direction.normalized() * 200
	enemy.move_and_slide()
	
	if enemy.position.distance_to(global.player_position) < 1 or follow_time.is_stopped():
		follow_time.stop()
		get_parent().change_state("idlestate")
	
func physics_update(delta: float):
	pass
	
func handle_input(event: InputEvent):
	pass
