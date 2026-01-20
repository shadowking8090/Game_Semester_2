extends CharacterBody2D

var theta: float = 0.0
@export_range(0,2*PI) var alpha: float = 0.0

@export var bullet_node: PackedScene
@export var parry_bullet_node: PackedScene
@onready var health: Health = $Health
@onready var hurt_box: HurtBox = $HurtBox
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var path_2d: Path2D = $"../.."

func _ready() -> void:
	global.bullet_parried.connect(bullet_parried)
	
	
func get_vector(angle) -> Vector2:
	theta = angle + alpha
	return Vector2(cos(theta), sin(theta))
	
func shoot(angle) -> void:
	var rando = randi_range(0,1)
	var bullet = bullet_node.instantiate()
	if rando == 0:
		bullet = parry_bullet_node.instantiate()
	
	bullet.position = global_position
	bullet.direction = get_vector(angle)
	
	get_tree().current_scene.call_deferred("add_child", bullet)
						 


func _on_speed_timeout() -> void:
	shoot(theta)
	
func spin(time: float) -> void:
	var timer = Timer.new()
	timer.one_shot
	timer.wait_time = time
	timer.autostart
	
func bullet_parried(hit_box):
	hurt_box.emit_signal("area_entered", hit_box)

func _on_health_health_depleted() -> void:
	path_2d.queue_free()
