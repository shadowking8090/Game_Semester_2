class_name RingState
extends State

@export var ring_bullet: PackedScene
@onready var enemy: CharacterBody2D = $"../.."
@onready var ring_timer: Timer = $"../../RingTimer"
@export var ring_count = 5
@onready var audio: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"

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
		audio.stream = load("res://Sounds/ghost_ring.mp3")
		audio.play()
		var bullet = ring_bullet.instantiate()
		bullet.position = enemy.global_position
		get_tree().current_scene.add_child(bullet)
		ring_timer.start()
		ring_count -= 1
	else:
		get_parent().change_state(global.states[randi_range(0,4)])
	
