extends Node2D

@onready var hit_box: HitBox = $RigidBody2D/HitBox


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		global.emit_signal("player_hit", hit_box)
