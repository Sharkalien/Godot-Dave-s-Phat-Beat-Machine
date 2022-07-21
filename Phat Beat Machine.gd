extends Node2D

onready var mKnob = $mKnob
onready var iKnob = $iKnob

var vols : Array = []
var playin : Array = []
var saves : Array = []
var jokeSongs : Array = []
onready var bbBeats : Array = [$Beats/BeatButton6,$Beats/BeatButton7,$Beats/BeatButton12,$Beats/BeatButton13,$Beats/BeatButton14,$Beats/BeatButton15,$Beats/BeatButton16]
var curFunc : int = 0
var mVol : bool = false
var iVol : bool = false
var rot = 0
var rott = 0
var rDiff = 180 / PI
var delay : int
var select : int = 0


func _ready():
	iKnob.spin.rotation_degrees = -179
	mKnob.spin.rotation_degrees = -179

func _process(_delta):
	mouseMove()
	pass

func mouseMove():
	var degrees = 0
	if mVol:
		degrees = rot + (rott - atan2(get_global_mouse_position().y - mKnob.position.y, get_global_mouse_position().x - mKnob.position.x) * rDiff)
		while degrees > 180:
			degrees -= 360
		while degrees < 180:
			degrees -= 360
		if degrees < 0 && mKnob.get_node("spin").rotation_degrees > 90:
			degrees = 179.9
		if degrees > 0 && mKnob.get_node("spin").rotation_degrees < -90:
			degrees = -179.9
		mKnob.get_node("spin").rotation_degrees = degrees


func _on_ProfessionalismButton_toggled(button_pressed):
	if button_pressed:
		for i in bbBeats:
			var path = i.audPlayer.stream.resource_path.replace(".mp3", " bol.mp3")
			print(path)
			var file = File.new()
			if file.file_exists(path):
				file.open(path, File.READ)
				var buffer = file.get_buffer(file.get_len())
				var stream = i.audPlayer.stream
				stream.data = buffer
				i.audPlayer.stream = stream
				if !i.audPlayer.playing:
					i.bButton.self_modulate = Color(1.00, 1.00, 1.00, 1.00)
		$ScreenLabel/AnimationPlayer.play("Scroll Bol")
	elif !button_pressed:
		for i in bbBeats:
			var path = i.audPlayer.stream.resource_path.replace(" bol.mp3", ".mp3")
			print(path)
			var file = File.new()
			if file.file_exists(path):
				file.open(path, File.READ)
				var buffer = file.get_buffer(file.get_len())
				var stream = i.audPlayer.stream
				stream.data = buffer
				i.audPlayer.stream = stream
				if !i.audPlayer.playing:
					i.bButton.self_modulate = Color(1.00, 1.00, 1.00, 1.00)
		$ScreenLabel/AnimationPlayer.play("Scroll")
