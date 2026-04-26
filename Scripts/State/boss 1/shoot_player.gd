class_name ShootPlayerState
extends State

@export var parry_bullet_node : PackedScene
@export var bullet_node : PackedScene
@onready var character: Node2D = $Character
@onready var enemy: CharacterBody2D = $"../.."
@onready var audio: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"

var wait_time = 0.2
var shoot_timer: Timer
var duration_timer: Timer

func enter():
	global.bullet_speed = 1000
	duration_timer = Timer.new()
	duration_timer.one_shot = true
	duration_timer.wait_time = 5
	duration_timer.timeout.connect(_on_duration_timer_timeout)
	add_child(duration_timer)
	duration_timer.start()
	shoot_timer = Timer.new()
	shoot_timer.wait_time = wait_time
	shoot_timer.timeout.connect(_on_shoot_timer_timeout)
	add_child(shoot_timer)
	shoot_timer.start()
	
func exit():
	audio.volume_db = 0
	print(name, " exiting to: ")
	if shoot_timer:
		shoot_timer.stop()
		shoot_timer.queue_free()
		shoot_timer = null
	if duration_timer:
		duration_timer.stop()
		duration_timer.queue_free()
		duration_timer = null

func shoot():
	audio.stream = load("res://Sounds/ghost_shot.mp3")
	audio.pitch_scale = randf_range(0.6, 1.8)
	audio.volume_db = 15
	audio.play()
	global.bullet_speed = global.bullet_speed
	var rando = randi_range(0,5)
	var bullet = bullet_node.instantiate()
	if rando == 0:
		bullet = parry_bullet_node.instantiate()
 
	bullet.position = enemy.global_position
	bullet.direction = (global.player_position - enemy.global_position).normalized()
 	
	bullet.speed = global.bullet_speed
	
	get_tree().current_scene.call_deferred("add_child",bullet)

func _on_shoot_timer_timeout():
	shoot()
	
func _on_duration_timer_timeout():
	shoot_timer.stop()
	state_machine.change_state(global.states[randi_range(0,4)])
