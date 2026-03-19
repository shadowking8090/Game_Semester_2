extends Sprite2D

@export var rotation_speed: float = 5.0
@export var rotation_offset: float = 0.0 

func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var target_angle = global_position.angle_to_point(mouse_pos) + deg_to_rad(rotation_offset)
	rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)
