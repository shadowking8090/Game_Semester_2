extends RigidBody2D

var dragging := false
var offset := Vector2.ZERO

@export var follow_strength := 20.0
@export var lerp_speed := 20.0
@export var release_max_speed := 700.0
@export var drag_damp := 6.0

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if not dragging:
		return

	var current_pos := state.transform.origin
	var target := get_global_mouse_position() - offset
	var dir := target - current_pos

	# Velocity toward mouse
	var desired_velocity := dir * follow_strength

	# Smooth with lerp
	var new_velocity := state.linear_velocity.lerp(
		desired_velocity,
		lerp_speed * state.step
	)

	# ---- Collision safety ----
	var contact_count := state.get_contact_count()
	for i in range(contact_count):
		var normal := state.get_contact_local_normal(i)

		# Remove velocity INTO the collision
		var into := new_velocity.dot(normal)
		if into < 0:
			new_velocity -= normal * into

	# Extra damping while dragging
	new_velocity *= 1.0 / (1.0 + drag_damp * state.step)

	state.linear_velocity = new_velocity

func _on_button_button_down() -> void:
	dragging = true
	offset = get_global_mouse_position() - global_position
	linear_velocity = Vector2.ZERO

func _on_button_button_up() -> void:
	dragging = false

	# Clamp ONLY on release
	if linear_velocity.length() > release_max_speed:
		linear_velocity = linear_velocity.normalized() * release_max_speed
