extends CanvasLayer

@onready var ammo_label: Label = $ammo_label

func _process(delta: float) -> void:
	ammo_label.text = "Ammo: " + str(global.player_ammo)
