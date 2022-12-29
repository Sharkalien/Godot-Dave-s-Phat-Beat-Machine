extends Node2D

onready var mKnob = $mKnob
onready var iKnob = $iKnob

var vols : Array = []
var playin : Array = []
var saves : Array = []
onready var jokeSongs : Array = [$Beats/JokeButton1,$Beats/JokeButton2,$Beats/JokeButton3,$Beats/JokeButton4]
var jokeSongsB : Array = ["res://beats joke/mspa_harlequin.mp3","res://beats joke/cp_close.mp3","res://beats joke/Bustin.mp3","res://beats joke/Aerosmith_-_I_Dont_Wanna_Miss_A_Thing.mp3"]
var jokeSongsC : Array = ["res://beats joke/john do the windy thing.mp3","res://beats joke/Trapezoid - Captain Planet Theme.mp3","res://beats joke/Busting Makes Me Feel Good.mp3","res://beats joke/Aerolong (Beta Mix) - Mouth Dreams.mp3"]
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


#func _process(_delta):
#	if Input.is_action_just_pressed("click"):
#		mouseMoveMasterVol()


func mouseMoveMasterVol():
	var degrees = 0
	degrees = rot + (rott - atan2(get_global_mouse_position().y - mKnob.rect_position.y, get_global_mouse_position().x - mKnob.rect_position.x) * rDiff)
#	while degrees > 180:
#		degrees -= 360
#	while degrees < 180:
#		degrees -= 360
	if degrees < 0 && mKnob.spin.rotation_degrees > 90:
		degrees = 179.9
	if degrees > 0 && mKnob.spin.rotation_degrees < -90:
		degrees = -179.9
	mKnob.spin.rotation_degrees = degrees
	print("poo")


func swapPath(orig: String, new:String):
	for i in bbBeats:
		var path = i.audPlayer.stream.resource_path.replace(orig, new)
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


func _on_ProfessionalismButton_toggled(button_pressed):
	if button_pressed:
		swapPath(".mp3", " bol.mp3")
		$ScreenLabel/AnimationPlayer.play("Scroll Bol")
	elif !button_pressed:
		swapPath(" bol.mp3", ".mp3")
		$ScreenLabel/AnimationPlayer.play("Scroll")


func replaceSongs(songsArray):
	for i in jokeSongs:
			var path = i.audPlayer.stream.resource_path.replace(i.audPlayer.stream.resource_path, songsArray[jokeSongs.find(i,0)])
			print(path)
			var file = File.new()
			if file.file_exists(path):
				file.open(path, File.READ)
				var buffer = file.get_buffer(file.get_len())
				var stream = i.audPlayer.stream
				stream.data = buffer
				i.audPlayer.stream = stream
				if !i.audPlayer.playing:
					i.jButton.get("custom_styles/panel/StyleBoxFlat").set_bg_color(Color(1.00, 1.00, 1.00, 1.00))
					i.jButton.get("custom_styles/panel/StyleBoxFlat").set_border_color(Color(0.8, 0.8, 0.8, 1.00))


# for some reason, toggling the button while a track is playing will occasionaly freeze crash the game
# only some of the time
func _on_CManButton_toggled(button_pressed):
	if button_pressed:
		replaceSongs(jokeSongsC)
	elif !button_pressed:
		replaceSongs(jokeSongsB)
