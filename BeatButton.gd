extends TextureButton

onready var audPlayer = $AudioStreamPlayer


func _on_BeatButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		audPlayer.playing = true
		self_modulate = Color(0.78, 0.99, 0.45, 1.00)
	else:
		audPlayer.playing = false
		self_modulate = Color(1.00, 1.00, 1.00, 1.00)
