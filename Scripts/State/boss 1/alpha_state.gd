class_name AlphaState
extends State

var theta: float = 0.0
@export_range(0,2*PI) var alpha: float = 0
var leaf_pattern = [3,2,1.5,1.3]
var leaf_index = 0

@export var bullet_node: PackedScene
@export var parry_bullet_node: PackedScene
@onready var enemy: CharacterBody2D = $"../.."
@onready var speed: Timer = $"../../Speed"
@onready var duration: Timer = $"../../Duration"
@onready var audio: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"

func enter():
	audio.stream = load("res://Sounds/Ghost_whoo.mp3")
	audio.pitch_scale = randf_range(0.6, 1.8)
	audio.play()
	global.bullet_speed = 400
	leaf_index = 0
	alpha = leaf_pattern[leaf_index]
	duration.start()
	speed.start()
	
func exit():
	print(name, " exiting to: ")
	duration.stop()
	speed.stop()

func get_vector(angle) -> Vector2:
	theta = angle + alpha
	return Vector2(cos(theta), sin(theta))
	
func shoot(angle) -> void:
	var rando = randi_range(0,10)
	var bullet = bullet_node.instantiate()
	if rando == 0:
		bullet = parry_bullet_node.instantiate()
	
	bullet.position = enemy.global_position
	bullet.direction = get_vector(angle)
	
	bullet.speed = global.bullet_speed
	
	get_tree().current_scene.call_deferred("add_child", bullet)
						 

func _on_speed_timeout() -> void:
	shoot(theta)
	
func spin(time: float) -> void:
	var timer = Timer.new()
	timer.one_shot
	timer.wait_time = time
	timer.autostart


func _on_duration_timeout() -> void:
	if state_machine.current_state != self:
		return
	leaf_index += 1
	if leaf_index > 3:
		duration.stop()
		speed.stop()
		state_machine.change_state(global.states[randi_range(0,4)])
	else:
		alpha = leaf_pattern[leaf_index]
		duration.start()
		speed.start()
