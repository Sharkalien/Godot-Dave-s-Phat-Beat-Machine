extends Node2D

onready var spin = $spin
var rot = 0
var rott = 0
var rDiff = 180 / PI
var isDown = false


func _mouseMove() -> void:
	var rotDegrees = 0
	rotDegrees = rot + (rott - atan2(get_global_mouse_position().y - position.y, get_global_mouse_position().x - position.x) * rDiff)
	while rotDegrees > 180:
		rotDegrees -= 360
	while rotDegrees < -180:
		rotDegrees += 360
	if rotDegrees < 0 && spin.rect_rotation > 90:
		rotDegrees = 179.9
	if rotDegrees > 0 && spin.rect_rotation < -90:
		rotDegrees = -179.9
	spin.rect_rotation = rotDegrees
	print(rotDegrees)


func _on_gui_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("click") and isDown:
		_mouseMove()


func _on_button_down() -> void:
	isDown = true
	rot = spin.rect_rotation
	rott = atan2(get_global_mouse_position().y - position.y, get_global_mouse_position().x - position.x) * rDiff


func _on_button_up() -> void:
	isDown = false
