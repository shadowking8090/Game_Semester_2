extends PathFollow2D

@export var speed: float = 0.1

func _physics_process(delta: float) -> void:
	progress_ratio += delta * speed
