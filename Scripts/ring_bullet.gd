extends Area2D

@onready var player = get_parent().find_child("character")
@onready var hit_box: HitBox = $HitBox
@onready var ring_bullet: Area2D = $"."

@export var grow_speed: float = 1
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

var direction: Vector2 = Vector2.ZERO
var target_scale: Vector2 = Vector2(1, 1)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	scale = scale.lerp(target_scale, -grow_speed * delta)

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var hurtbox = body.get_node("HurtBox")
		if hurtbox:
			hurtbox._on_area_entered(hit_box)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	ring_bullet.queue_free()
