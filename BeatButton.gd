extends TextureButton

onready var audPlayer = $AudioStreamPlayer
onready var bButton = $"."


func _on_BeatButton_pressed():
	if !audPlayer.playing:
		audPlayer.playing = true
		bButton.self_modulate = Color(0.78, 0.99, 0.45, 1.00)
	elif audPlayer.playing:
		audPlayer.playing = false
		bButton.self_modulate = Color(1.00, 1.00, 1.00, 1.00)
