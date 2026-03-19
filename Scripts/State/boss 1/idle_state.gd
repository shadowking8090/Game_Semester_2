class_name IdleState
extends State

@onready var player_detection: Area2D = $"../../PlayerDetection"
var triggered: bool = false

func enter():
	print("Entering Idle State, came from: ", state_machine.previous_state)
	triggered = false
	if global.player_entered:
		state_machine.change_state("alphastate")

func exit():
	triggered = false

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not triggered:
		player_detection.position.x = 20000
		triggered = true
		global.player_entered = true
		state_machine.change_state("alphastate")
