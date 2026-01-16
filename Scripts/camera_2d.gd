extends Camera2D
@onready var camera_2d: Camera2D = $"."
@onready var character_body_2d: CharacterBody2D = $".."

@export var lerp_speed: float = 2

func _process(delta: float) -> void:
	if Input.is_action_pressed("mouse_left"):
		offset = offset.lerp(character_body_2d.velocity, delta * lerp_speed)
	if Input.is_action_just_released("mouse_left"):
		offset = offset.lerp(Vector2(character_body_2d.position.x, character_body_2d.position.y), delta * lerp_speed)
