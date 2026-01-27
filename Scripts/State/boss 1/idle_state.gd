class_name IdleState
extends State

var player_entered = false
@onready var player_detection: Area2D = $"../../PlayerDetection"

func enter():
	if global.player_entered:
		print("Entering Idle State")
		state_machine.change_state("alphastate")
	


func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		global.player_entered = true
		enter()
		player_detection.queue_free()
