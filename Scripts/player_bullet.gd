extends Area2D
@onready var player_bullet: Area2D = $"."

@export var speed: float = 800.0
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	player_bullet.queue_free()
