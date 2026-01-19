extends CharacterBody2D

@export var speed := 600
@export var dash_speed := 300
@export var dash_cooldown := 0.5
@export var max_dash_distance := 75
@onready var health: Health = $Health

@onready var dash_bar := $CanvasLayer/DashCooldownBar

var dash_direction := Vector2.ZERO
var dash_distance_left := 0.0
var dash_timer := 0.0
var can_dash := true
var is_dashing := false

func _physics_process(delta):
	update_dash_cooldown(delta)

	if is_dashing:
		health.set_immortality(true)
		var step = dash_speed * delta
		dash_distance_left -= step

		if dash_distance_left <= 0:
			is_dashing = false
			velocity = Vector2.ZERO
	else:
		health.set_immortality(false)
		Move(delta)
		Dash()

	move_and_slide()




func Move(delta):
	var mouse_pos = get_global_mouse_position()
	var dist = global_position.distance_to(mouse_pos)

	if Input.is_action_pressed("mouse_left") and dist > 40:
		var dir = global_position.direction_to(mouse_pos)
		velocity = dir * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed * 6 * delta)

func Dash():
	if not can_dash:
		return

	if Input.is_action_just_pressed("mouse_right"):
		var mouse_pos = get_global_mouse_position()
		var dist = global_position.distance_to(mouse_pos)

		dash_direction = global_position.direction_to(mouse_pos)
		dash_distance_left = min(dist, max_dash_distance)

		velocity = dash_direction * dash_speed
		is_dashing = true
		can_dash = false
		dash_timer = 0.0



func update_dash_cooldown(delta):
	if not can_dash:
		dash_timer += delta
		dash_bar.value = dash_timer / dash_cooldown

		if dash_timer >= dash_cooldown:
			dash_timer = dash_cooldown
			can_dash = true
	else:
		dash_bar.value = 1

func debug():
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()

func _on_health_health_depleted() -> void:
	get_tree().reload_current_scene()
