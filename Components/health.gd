class_name Health
extends Node

signal damaged(amount)
signal health_depleted

@export var max_health: int = 3
@export var health: int = 3
@export var immortality: bool = false

var immortality_timer: Timer = null

func _ready() -> void:
	health = max_health

func set_health(value: int) -> void:
	if value < health and immortality:
		return  
	health = clamp(value, 0, max_health)
	if health == 0:
		health_depleted.emit()

func get_max_health() -> int: 
	return max_health
	
func set_immortality(value: bool) -> void: 
	immortality = value 

func get_immortality() -> bool: 
	return immortality

func set_temporary_immortality(time: float) -> void:
	if immortality_timer == null:
		immortality_timer = Timer.new()
		immortality_timer.one_shot = true
		add_child(immortality_timer)

	immortality = true

	immortality_timer.wait_time = time
	immortality_timer.timeout.connect(func():
		immortality = false
	)
	immortality_timer.start()

func take_damage(amount: int, temp_immortality: float = 0.0) -> void:
	if immortality:
		return 
	set_health(health - amount)
	damaged.emit(amount)
	if temp_immortality > 0:
		set_temporary_immortality(temp_immortality)
