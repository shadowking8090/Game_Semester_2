class_name HurtBox
extends Area2D


signal received_damage(damage: int)

@onready var sprite_2d: Sprite2D = $"../Sprite2D"
@export var health: Health
@export var immortality_time = 0.2


func _ready():
	connect("area_entered", _on_area_entered)


func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:
		print("5")
		health.health -= hitbox.damage
		received_damage.emit(hitbox.damage)
		sprite_2d.modulate = Color(randf(), randf(), randf())
