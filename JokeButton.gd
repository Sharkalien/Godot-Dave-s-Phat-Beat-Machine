extends Button

onready var audPlayer:AudioStreamPlayer = $AudioStreamPlayer


func _on_JokeButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		audPlayer.play()
	else:
		audPlayer.stop()
