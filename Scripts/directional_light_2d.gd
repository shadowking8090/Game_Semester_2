extends DirectionalLight2D

@export var base_energy := 0.4
@export var flicker_amount := 0.08
var target_energy: float
var current_energy: float

func _ready():
	current_energy = base_energy
	target_energy = base_energy

func _process(delta):
	if randf() < 0.03:  
		target_energy = base_energy + randf_range(-flicker_amount, flicker_amount)
	current_energy = lerp(current_energy, target_energy, delta * 3.0)
	energy = current_energy
