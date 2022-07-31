extends Sprite


var sprite_rotation = 0
var click_pos = Vector2.ZERO
var move_delta = Vector2.ZERO

var is_dragging = false

func _input(event):
	# second condition tests whether the click occured within the area of the sprite
	if Input.is_action_just_pressed("click") && get_rect().has_point(to_local(event.position)):
		click_pos = event.position
		is_dragging = true
	elif Input.is_action_just_released("click"):
		sprite_rotation = self.rotation_degrees
		is_dragging = false
	
	if is_dragging:
		move_delta = click_pos - event.position
		self.rotation_degrees = -move_delta.x + sprite_rotation


func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		click_pos = event.position
		is_dragging = true
	elif Input.is_action_just_released("click"):
		sprite_rotation = self.rotation_degrees
		is_dragging = false
	
	if is_dragging:
		move_delta = click_pos - event.position
		self.rotation_degrees = -move_delta.x + sprite_rotation
