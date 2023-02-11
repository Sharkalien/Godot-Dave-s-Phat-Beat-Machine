extends Path2D

onready var path = curve.get_baked_points()

onready var path_follow = $PathFollow2D


#func _ready() -> void:
#	print(path)
#	pass


func _on_QLSlider_gui_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("click"):
		var mouse_pos = get_global_mouse_position()
		path_follow.offset = curve.get_closest_offset(mouse_pos)
#		print(path_follow.offset)
