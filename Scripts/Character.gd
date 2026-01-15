extends CharacterBody2D

@export var speed = 50

func _ready() -> void: 
	position = get_global_mouse_position()
func _process(delta: float) -> void:
	global_position = global_position.lerp(get_global_mouse_position(), speed * delta)
