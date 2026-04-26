extends CharacterBody2D

@export var player_bullet : PackedScene
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var end_screen: Control = get_node("/root/World/EndScreen")
@onready var container: Node2D = get_node("/root/World/Container")
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var hurt_player: AudioStreamPlayer2D = $HurtPlayer

@export var speed := 600
@export var dash_speed := 300
@export var dash_cooldown := 0.5
@export var max_dash_distance := 75
@onready var health: Health = $Health
@onready var hurt_box: HurtBox = $HurtBox

@onready var dash_bar: TextureProgressBar = $CanvasLayer/DashCooldownBar
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

var dash_direction := Vector2.ZERO
var dash_distance_left := 0.0
var dash_timer := 0.0
var can_dash := true
var is_dashing := false
var shoot_cooldown: float = 0


func _ready() -> void:
	global.player_hit.connect(player_hit)
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.stream = load("res://Sounds/button_sound.mp3")
	audio.play()
	
	
func player_hit(hitbox):
		sprite_2d.modulate = Color.RED
		await get_tree().create_timer(0.15).timeout
		sprite_2d.modulate = Color.WHITE
		hurt_player.pitch_scale = randf_range(0.8, 1.4)
		hurt_player.play()

func _physics_process(delta):
	shoot_cooldown -= delta
	global.player_position = global_position
	debug()
	update_dash_cooldown(delta)
	cpu_particles_2d.direction = get_global_mouse_position()
	
	if Input.is_action_just_pressed("mouse_left"):
		if shoot_cooldown <= 0:
			shoot()
			shoot_cooldown = 0.15

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

	if dist > 40 and not is_dashing:
		var dir = global_position.direction_to(mouse_pos)
		velocity = dir * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed * 6 * delta)

func Dash():
	if not can_dash:
		return

	if Input.is_action_just_pressed("mouse_right"):
		audio.stream = load("res://Sounds/paper_dash.mp3")
		audio.pitch_scale = randf_range(0.9, 1.1)
		audio.play()
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
		
func shoot():
	if global.player_ammo > 0:
		audio.stream = load("res://Sounds/paper_cut.mp3")
		audio.pitch_scale = randf_range(0.9, 1.1)
		audio.play()
		var bullet = player_bullet.instantiate()
		bullet.global_position = global_position
		var direction = (get_global_mouse_position() - global_position).normalized()
		bullet.direction = direction
		get_tree().root.add_child(bullet)
		global.player_ammo -= 1



func update_dash_cooldown(delta):
	if not can_dash:
		dash_timer += delta
		dash_bar.value = dash_timer / dash_cooldown
		if dash_timer >= dash_cooldown:
			dash_timer = dash_cooldown
			can_dash = true
			dash_bar.value = 1.0

func debug():
	if Input.is_action_just_pressed("Restart"):
		global.player_ammo = 3
		get_tree().reload_current_scene()
		


func _on_health_health_depleted() -> void:
	global.player_ammo = 3
	end_screen.visible = true
	container.process_mode = Node.PROCESS_MODE_DISABLED
