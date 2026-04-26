class_name HurtBox
extends Area2D

signal received_damage(damage: int)

@export var health: Health
@export var immortality_time: float = 0.2
@onready var progress_bar: ProgressBar = $"../CanvasLayer/ProgressBar"

func _ready():
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null or health == null:
		return
	if health.immortality == true:
		return
	health.take_damage(hitbox.damage, immortality_time)
	received_damage.emit(hitbox.damage)
	if is_in_group("Player"):
		global.player_hit.emit(hitbox)
	if progress_bar != null:
		progress_bar.value = health.health
