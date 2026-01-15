extends Camera2D
@onready var camera_2d: Camera2D = $"."
@onready var character_body_2d: CharacterBody2D = $".."

@export var lerp_speed: float = 2

func _process(delta: float) -> void:
	offset = offset.lerp(character_body_2d.velocity, delta * lerp_speed)
