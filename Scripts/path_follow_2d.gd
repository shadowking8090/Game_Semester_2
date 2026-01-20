extends PathFollow2D

@export var speed: float = 0.1
@onready var enemy: CharacterBody2D = $Enemy
@onready var idle: Node2D = $Enemy/FiniteStateMachine/Idle

func _physics_process(delta: float) -> void:
	if idle.player_entered:
		progress_ratio += delta * speed
