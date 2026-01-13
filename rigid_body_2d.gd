extends RigidBody2D

var dragging = false
var dragger
var joint

func _input_event(_Viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
			createDragger()
			dragger.position = event.position
			dragger.get_child(0).node_b = get_path()
			
func _input(event):
	if event is InputEventMouseMotion and dragging:
		dragger.move_and_collide(event.relative)
		angular_damp = 5

	if event is InputEventMouseButton:
		if !event.is_pressed() and dragging and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = false
			dragger.queue_free()
			
func createDragger():
	dragger = StaticBody2D.new()
	joint = PinJoint2D.new()
	dragger.add_child(joint)
	owner.add_child(dragger)
	joint.node_a = dragger.get_path()
