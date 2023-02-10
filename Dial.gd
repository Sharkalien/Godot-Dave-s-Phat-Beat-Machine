extends TextureButton

onready var spin = $spin
var rot = -179.9
var rott = 0
var rDiff = 180 / PI


func _mouseMove() -> void:
	var rotDegrees = 0
	rotDegrees = rot + (rott - atan2(get_global_mouse_position().y - rect_position.y, get_global_mouse_position().x - rect_position.x) * rDiff)
	while rotDegrees > 180:
		rotDegrees -= 360
	while rotDegrees < -180:
		rotDegrees += 360
	if rotDegrees < 0 && spin.rotation_degrees > 90:
		rotDegrees = 179.9
	if rotDegrees > 0 && spin.rotation_degrees < -90:
		rotDegrees = -179.9
	spin.rotation_degrees = rotDegrees
	print(rotDegrees)


func _on_Dial_gui_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("click"):
		_mouseMove()


func _on_Dial_button_down() -> void:
	
	rot = spin.rotation_degrees
	rott = atan2(get_global_mouse_position().y - rect_position.y, get_global_mouse_position().x - rect_position.x) * rDiff
