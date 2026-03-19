extends Area2D

@onready var hit_box: HitBox = $HitBox

@export var grow_speed: float = 1

var direction: Vector2 = Vector2.ZERO
var target_scale: Vector2 = Vector2(1, 1)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	scale = scale.lerp(target_scale, -grow_speed * delta)

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		global.emit_signal("player_hit", hit_box)
