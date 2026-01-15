extends CharacterBody2D

@export var speed = 600 

func _ready() -> void: 
	position = get_global_mouse_position()
func _process(delta: float) -> void:
	if Input.is_action_pressed("mouse_left"):
		velocity = global_position.direction_to(get_global_mouse_position()) * speed
		if global_position.distance_to(get_global_mouse_position()) > 10:
			move_and_slide()
			
	
