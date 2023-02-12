extends Node2D

onready var mKnob = $mKnob # master volume
onready var iKnob = $iKnob # individual sample volume

var vols : Array = []
var playin : Array = []
var saves : Array = []
onready var jokeSongs : Array = [$Beats/JokeButton1,$Beats/JokeButton2,$Beats/JokeButton3,$Beats/JokeButton4]
var jokeSongsB : Array = [
	"res://beats joke/mspa_harlequin.mp3",
	"res://beats joke/cp_close.mp3",
	"res://beats joke/Bustin.mp3",
	"res://beats joke/Aerosmith_-_I_Dont_Wanna_Miss_A_Thing.mp3"]
var jokeSongsC : Array = [
	"res://beats joke/john do the windy thing.mp3",
	"res://beats joke/Trapezoid - Captain Planet Theme.mp3",
	"res://beats joke/Busting Makes Me Feel Good.mp3",
	"res://beats joke/Aerolong (Beta Mix) - Mouth Dreams.mp3"]
onready var bbBeats : Array = [
	$Beats/BeatButton6,$Beats/BeatButton7,$Beats/BeatButton12,
	$Beats/BeatButton13,$Beats/BeatButton14,$Beats/BeatButton15,$Beats/BeatButton16]
var curFunc : int = 0
var delay : int
var select : int = 0


func _ready():
	iKnob.spin.rect_rotation = -179
	mKnob.spin.rect_rotation = -179


func swapPath(orig:String, new:String):
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
			if i.pressed:
				i.pressed = false


func _on_ProfessionalismButton_toggled(button_pressed):
	if button_pressed:
		swapPath(".mp3", " bol.mp3")
		$ScreenLabel/AnimationPlayer.play("Scroll Bol")
	elif !button_pressed:
		swapPath(" bol.mp3", ".mp3")
		$ScreenLabel/AnimationPlayer.play("Scroll")


func replaceSongs(songsArray:Array):
	for i in jokeSongs:
		#maybe I should yield while finding i's index in the jokeSongs array before continuing execution??
		var path = i.audPlayer.stream.resource_path.replace(i.audPlayer.stream.resource_path, songsArray[jokeSongs.find(i,0)])
		print(path)
		var file = File.new()
		if file.file_exists(path):
			file.open(path, File.READ)
			var buffer = file.get_buffer(file.get_len())
			var stream = i.audPlayer.stream
			stream.data = buffer
			i.audPlayer.stream = stream
			if i.pressed:
				i.pressed = false


# for some reason, toggling the button while a track is playing will occasionaly freeze and crash the game
# only if the first and last buttons are toggled alone or together
func _on_CManButton_toggled(button_pressed):
	if button_pressed:
		replaceSongs(jokeSongsC)
	elif !button_pressed:
		replaceSongs(jokeSongsB)
