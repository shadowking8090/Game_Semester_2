extends CharacterBody2D

@export var speed := 600
@export var dash_speed := 300
@export var dash_cooldown := 0.5
@export var max_dash_distance := 75
@onready var health: Health = $Health
@onready var hurt_box: HurtBox = $HurtBox

@onready var dash_bar := $CanvasLayer/DashCooldownBar
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

var dash_direction := Vector2.ZERO
var dash_distance_left := 0.0
var dash_timer := 0.0
var can_dash := true
var is_dashing := false

func _ready() -> void:
	global.player_hit.connect(player_hit)
	
func player_hit(hitbox):
	hurt_box.emit_signal("area_entered", hitbox)

func _physics_process(delta):
	global.player_position = global_position
	debug()
	update_dash_cooldown(delta)
	cpu_particles_2d.direction = get_global_mouse_position()

	if is_dashing:
		var step = dash_speed * delta
		dash_distance_left -= step

		if dash_distance_left <= 0 or Input.is_action_just_released("mouse_right"):
			remove_from_group("is_dashing")
			is_dashing = false
			velocity = Vector2.ZERO
			health.immortality = false
			cpu_particles_2d.emitting = false

	else:
		Move(delta)
		Dash()

	move_and_slide()




func Move(delta):
	var mouse_pos = get_global_mouse_position()
	var dist = global_position.distance_to(mouse_pos)

	if Input.is_action_pressed("mouse_left") and dist > 40 and not is_dashing:
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
		add_to_group("is_dashing")
		is_dashing = true
		can_dash = false
		dash_timer = 0.0
		cpu_particles_2d.emitting = true
		health.immortality = true



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
