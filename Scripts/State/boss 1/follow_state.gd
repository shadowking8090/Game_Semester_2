class_name FollowState
extends State

@onready var enemy: CharacterBody2D = $"../.."
@onready var player_follow: Area2D = $"../../PlayerFollow"
@onready var follow_time: Timer = $"../../FollowTime"


func enter():
	follow_time.start()
	
func exit():
	print(name, " exiting to: ")
	follow_time.stop()
	
func update(delta: float):
	var direction = global.player_position - enemy.position
	
	enemy.velocity = direction.normalized() * 200
	enemy.move_and_slide()
	
	if follow_time.is_stopped():
		follow_time.stop()
		state_machine.change_state("ringstate")
	
func physics_update(delta: float):
	pass
	
func handle_input(event: InputEvent):
	pass
