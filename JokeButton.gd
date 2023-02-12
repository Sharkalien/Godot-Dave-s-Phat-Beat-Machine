extends Button

onready var audPlayer = $AudioStreamPlayer


func _on_JokeButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		audPlayer.playing = true
	else:
		audPlayer.playing = false
