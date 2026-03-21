extends Node2D

@export var swing_degrees: float = 20.0
@export var swing_speed: float = 1.5

var time: float = 0.0

func _process(delta: float) -> void:
	time += delta
	rotation = deg_to_rad(sin(time * swing_speed) * swing_degrees)
