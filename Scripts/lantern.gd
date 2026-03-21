extends Node2D

@export var bullet_node: PackedScene
@onready var shoot_timer: Timer = $ShootTimer
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var swing_degrees: float = 20.0
@export var swing_speed: float = 1.5

var time: float = 0.0


func _ready() -> void:
	shoot_timer.start()


func _physics_process(delta: float) -> void:
	time += delta
	rotation = deg_to_rad(sin(time * swing_speed) * swing_degrees)


func shoot():
	var bullet = bullet_node.instantiate()
	
	bullet.global_position = sprite_2d.global_position
	get_tree().root.add_child(bullet)

func _on_shoot_timer_timeout() -> void:
	shoot()
	shoot_timer.wait_time = randf_range(0.4,2)
