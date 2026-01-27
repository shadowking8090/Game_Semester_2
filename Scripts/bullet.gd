extends Area2D

var speed = 300 
var direction = Vector2.RIGHT
@onready var hit_box: HitBox = $HitBox

func _physics_process(delta: float) -> void:
	position += direction * speed * delta 

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and body.is_in_group("is_dashing"):
		global.emit_signal("bullet_parried", hit_box)
		queue_free()
