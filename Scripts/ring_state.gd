class_name RingState
extends State

@export var ring_bullet: PackedScene
@onready var enemy: CharacterBody2D = $"../.."
@onready var ring_timer: Timer = $"../../RingTimer"
@export var ring_count = 5

func enter():
	ring_count = 5
	ring_timer.start()
	
func exit():
	print(name, " exiting to: ")
	ring_timer.stop()
	
func update(delta: float):
	pass
	
func physics_update(delta: float):
	pass
	
func handle_input(event: InputEvent):
	pass


func _on_ring_timer_timeout() -> void:
	if ring_count > 0:
		var bullet = ring_bullet.instantiate()
		bullet.position = enemy.global_position
		get_tree().current_scene.add_child(bullet)
		ring_timer.start()
		ring_count -= 1
	else:
		get_parent().change_state("idlestate")
	
