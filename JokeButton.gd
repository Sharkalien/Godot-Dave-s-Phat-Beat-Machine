extends Panel

onready var audPlayer = $AudioStreamPlayer
onready var jButton = $"."


func _on_JokeButton_gui_input(event):
	if event.is_pressed():
		if audPlayer.playing == false:
			audPlayer.playing = true
			jButton.get("custom_styles/panel/StyleBoxFlat").set_bg_color(Color(0.78, 0.99, 0.45, 1.00))
			jButton.get("custom_styles/panel/StyleBoxFlat").set_border_color(Color(0.74, 0.95, 0.41, 1.00))
		elif audPlayer.playing == true:
			audPlayer.playing = false
			jButton.get("custom_styles/panel/StyleBoxFlat").set_bg_color(Color(1.00, 1.00, 1.00, 1.00))
			jButton.get("custom_styles/panel/StyleBoxFlat").set_border_color(Color(0.8, 0.8, 0.8, 1.00))
