extends TextureButton

const BEAT_SCRIPT = preload("res://BeatButton.gd")

var save : Array = []
var beat_buttons : Array = []


func _ready() -> void:
	for beat in get_owner().get_node("Beats").get_children():
		if beat.get_script() == BEAT_SCRIPT:
			beat_buttons.append(beat)
	
	save = _capture_state()
	disabled = pressed
	if pressed:
		Global.curFunc = self


func _capture_state() -> Array:
	var snapshot : Array = []
	for beat in beat_buttons:
		var player = beat.get_node("AudioStreamPlayer")
		var bus_index = AudioServer.get_bus_index(player.bus)
		snapshot.append({"pressed": beat.pressed, "volume_db": AudioServer.get_bus_volume_db(bus_index)})
#	print(snapshot)
	return snapshot


func _on_FuncButton_toggled(button_pressed: bool) -> void:
	disabled = button_pressed
	if not button_pressed or Global.curFunc == self:
		return
	
	var previous = Global.curFunc
	if previous != null:
		previous.save = previous._capture_state()
	Global.curFunc = self
	_restore_state()


func _restore_state() -> void:
	for i in range(beat_buttons.size()):
		var player = beat_buttons[i].get_node("AudioStreamPlayer")
		var bus_index = AudioServer.get_bus_index(player.bus)
		AudioServer.set_bus_volume_db(bus_index, save[i]["volume_db"])
	
	for beat in beat_buttons:
		if beat.pressed and beat.audPlayer.playing:
			Global.prevBeat = beat.audPlayer
			break
	for i in range(beat_buttons.size()):
		if save[i]["pressed"] and not beat_buttons[i].pressed:
			beat_buttons[i].pressed = true
	for i in range(beat_buttons.size()):
		if not save[i]["pressed"] and beat_buttons[i].pressed:
			beat_buttons[i].pressed = false
	
	var selected_player : AudioStreamPlayer = null
	for beat in beat_buttons:
		if beat.pressed:
			if selected_player == null or beat.audPlayer == Global.curBeat:
				selected_player = beat.audPlayer
	
	Global.curBeat = selected_player
	Global.prevBeat = Global.curBeat
	if Global.curBeat != null:
		var bus_index = AudioServer.get_bus_index(Global.curBeat.bus)
		var volume = db2linear(AudioServer.get_bus_volume_db(bus_index))
		get_owner().get_node("iKnob/spin").rect_rotation = 180 - volume * 360
