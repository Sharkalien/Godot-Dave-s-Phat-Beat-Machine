extends TextureButton

onready var audPlayer:AudioStreamPlayer = $AudioStreamPlayer


func _on_BeatButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		audPlayer.play()
		self_modulate = Color(0.78, 0.99, 0.45, 1.00)
	else:
		audPlayer.stop()
		self_modulate = Color(1.00, 1.00, 1.00, 1.00)
