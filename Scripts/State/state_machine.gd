class_name StateMachine
extends Node

@export var initial_state: State
var current_state: State
var previous_state: String = ""
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_machine = self
	
	if initial_state:
		change_state(initial_state.name.to_lower())
		
		
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
	
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
	
func _input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)
	
func change_state(new_state: String) -> void:
	if current_state:
		previous_state = current_state.name
		current_state.exit()
	
	print("Changing state from: ", previous_state, " to: ", new_state)
	current_state = states.get(new_state.to_lower())
	
	if current_state:
		current_state.enter()
