extends Path2D

onready var pathFollow = $PathFollow2D


func _on_QLSlider_gui_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("click"):
		var mousePos = get_global_mouse_position()
		pathFollow.offset = curve.get_closest_offset(mousePos)
#		print(pathFollow.offset)
