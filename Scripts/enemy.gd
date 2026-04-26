extends CharacterBody2D

@onready var player = get_parent().find_child("character")
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var parry_sound: AudioStreamPlayer2D = $ParrySound
@onready var hurt_sound: AudioStreamPlayer2D = $HurtSound


var theta: float = 0.0
@export_range(0,2*PI) var alpha: float = 0.0

@export var speed = 300

@export var bullet_node: PackedScene
@export var parry_bullet_node: PackedScene
@onready var health: Health = $Health
@onready var hurt_box: HurtBox = $HurtBox
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var progress_bar: TextureProgressBar = $ProgressBar
@onready var damage: ColorRect = $Damage
@onready var anchor_light: Node2D = $"../AnchorLight"

func _ready() -> void:
	$Health.damaged.connect(_on_damaged)
	progress_bar.max_value = health.get_max_health()
	progress_bar.value = health.get_max_health()
	global.bullet_parried.connect(bullet_parried)
	
func _on_damaged(amount):
	if health.health > 0:
		progress_bar.value = health.health
		hurt_sound.stream = load("res://Sounds/ghost_ow.mp3")
		hurt_sound.pitch_scale = randf_range(0.8, 1.3)
		hurt_sound.play()
		sprite_2d.modulate = Color.GRAY
		await get_tree().create_timer(0.15).timeout
		sprite_2d.modulate = Color.WHITE
		if health.health < 9:
			anchor_light.visible = true
			anchor_light.process_mode = Node.PROCESS_MODE_ALWAYS
	
func bullet_parried(hitbox):
	parry_sound.stream = load("res://Sounds/parry.mp3")
	parry_sound.pitch_scale = randf_range(0.9, 1.1)
	parry_sound.play(0.91)
	global.frame_freeze(0.05)
	global.player_ammo += 3
	progress_bar.value = health.health
	

func _on_health_health_depleted() -> void:
	get_tree().change_scene_to_file("res://Scenes/end_screen.tscn")
	queue_free()
