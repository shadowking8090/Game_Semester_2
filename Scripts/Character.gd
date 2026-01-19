extends CharacterBody2D

@export var speed = 600 

func _ready() -> void: 
	global_position = Vector2(544,320)
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("mouse_left"):
		velocity = global_position.direction_to(get_global_mouse_position()) * speed
		if global_position.distance_to(get_global_mouse_position()) > 10:
			move_and_slide()
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()


func _on_health_health_depleted() -> void:
	get_tree().reload_current_scene()
