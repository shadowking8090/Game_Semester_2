extends TextureProgressBar

@onready var health: Health = $"../Health"

func _ready():
	max_value = health.max_health
	
func _process(delta: float) -> void:
	value = health.health
