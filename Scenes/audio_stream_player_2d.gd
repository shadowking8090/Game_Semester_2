extends AudioStreamPlayer2D

func _ready() -> void:
	play(randi_range(0,2000))
