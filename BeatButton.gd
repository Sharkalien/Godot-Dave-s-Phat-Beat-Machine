extends TextureButton

onready var audPlayer:AudioStreamPlayer = $AudioStreamPlayer
onready var iKnobSpin:TextureButton = get_owner().get_node("iKnob/spin")


#func _process(_delta: float) -> void:
#	if audPlayer.playing:
#		print(audPlayer.get_playback_position())
#		print(Global.prevBeat.stream)

# think of prevBeat as refBeat, the beat used as reference
func _on_BeatButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		Global.curBeat = audPlayer
		if !Global.prevBeat || !Global.prevBeat.playing:
			Global.prevBeat = Global.curBeat
		if Global.prevBeat:
			audPlayer.play(Global.prevBeat.get_playback_position())
			var curBus = AudioServer.get_bus_index(Global.curBeat.bus)
			iKnobSpin.rect_rotation = 360 - db2linear(AudioServer.get_bus_volume_db(curBus)) * 360 - 180
		else:
			audPlayer.play()
			print("fail")
		self_modulate = Color(0.78, 0.99, 0.45, 1.00)
	else:
		audPlayer.stop()
		self_modulate = Color(1.00, 1.00, 1.00, 1.00)
		if !Global.prevBeat.playing:
			Global.prevBeat = Global.curBeat
#		else:
#			Global.prevBeat = Global.curBeat
