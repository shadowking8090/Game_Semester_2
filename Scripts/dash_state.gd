class_name DashState
extends State

func enter():
	dash()
	
func exit():
	print(name, " exiting to: ")

func dash():
	var player = get_tree().get_first_node_in_group("Player")
	var target = player.global_position
	var tween = create_tween()
	tween.tween_property(owner, "global_position", target, 0.7)
	await tween.finished
	get_parent().change_state("idlestate")
