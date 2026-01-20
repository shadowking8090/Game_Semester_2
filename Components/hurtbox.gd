class_name HurtBox
extends Area2D


signal received_damage(damage: int)
signal parried_damage(damage: int)

@onready var sprite_2d: Sprite2D = $"../Sprite2D"
@export var health: Health
@export var immortality_time = 0.2


func _ready():
	connect("area_entered", _on_area_entered)


func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:
		print(health.get_health())
		health.health -= hitbox.damage
		received_damage.emit(hitbox.damage)
		if health.get_immortality() == false:
			sprite_2d.modulate = Color(randf(), randf(), randf())
		health.set_temporary_immortality(immortality_time)
		
