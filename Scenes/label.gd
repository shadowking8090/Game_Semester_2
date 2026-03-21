extends Label

@onready var health: Health = $"../Health"

func _process(delta: float) -> void:
	text = str(health.health)
