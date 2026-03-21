extends CharacterBody2D

@onready var player = get_parent().find_child("character")

var theta: float = 0.0
@export_range(0,2*PI) var alpha: float = 0.0

@export var speed = 300

@export var bullet_node: PackedScene
@export var parry_bullet_node: PackedScene
@onready var health: Health = $Health
@onready var hurt_box: HurtBox = $HurtBox
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label
@onready var damage: ColorRect = $Damage

func _ready() -> void:
	$Health.damaged.connect(_on_damaged)
	label.text = str(health.get_max_health())
	global.bullet_parried.connect(bullet_parried)
	
func _on_damaged(amount):
	sprite_2d.modulate = Color.RED
	await get_tree().create_timer(0.15).timeout
	sprite_2d.modulate = Color.WHITE
	
func bullet_parried(hitbox):
	global.frame_freeze(0.05)
	global.player_ammo = 3
	label.text = str(health.health)
	

func _on_health_health_depleted() -> void:
	queue_free()
