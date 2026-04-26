class_name DashState
extends State
@onready var audio: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"

func enter():
	dash()
	
func exit():
	audio.volume_db = 0
	print(name, " exiting to: ")

func dash():
	audio.stream = load("res://Sounds/ghost_dash.mp3")
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.volume_db = 24
	audio.play()
	var player = get_tree().get_first_node_in_group("Player")
	var target = player.global_position
	var tween = create_tween()
	tween.tween_property(owner, "global_position", target, 0.9)
	await tween.finished
	get_parent().change_state(global.states[randi_range(0,4)])
