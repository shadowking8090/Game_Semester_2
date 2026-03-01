extends PathFollow2D

@export var speed: float = 0.08
@onready var enemy: CharacterBody2D = $Enemy
@onready var on: Timer = $Enemy/On
@onready var off: Timer = $Enemy/Off
var started = global.player_entered


func _ready() -> void:
	on.start()
	
func _physics_process(delta: float) -> void:
	if global.player_entered:
		progress_ratio += delta * speed


func _on_on_timeout() -> void:
	speed = 0
	on.wait_time = randf_range(3,5)
	off.start()


func _on_off_timeout() -> void:
	speed = 0.08
	off.wait_time = randf_range(5,8)
	on.start()
