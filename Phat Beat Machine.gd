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
onready var camera = $Camera2D

var jokeBeats : int = 0
var curFunc : int = 0
var delay : int
var select : int = 0


func _ready():
	iKnob.spin.rect_rotation = -179
	mKnob.spin.rect_rotation = -179


func swapPath(orig:String, new:String):
	for i in bbBeats:
		if i.pressed:
			i.pressed = false
		var path = i.audPlayer.stream.resource_path.replace(orig, new)
		print(path)
		i.audPlayer.stream = load(path)


func _on_ProfessionalismButton_toggled(button_pressed):
	if button_pressed:
		swapPath(".mp3", " bol.mp3")
		$ScreenLabel/AnimationPlayer.play("Scroll Bol")
	elif !button_pressed:
		swapPath(" bol.mp3", ".mp3")
		$ScreenLabel/AnimationPlayer.play("Scroll")


func replaceSongs(songsArray:Array):
	for i in jokeSongs:
		if i.pressed:
			i.pressed = false
		var path = i.audPlayer.stream.resource_path.replace(i.audPlayer.stream.resource_path, songsArray[jokeSongs.find(i,0)])
		print(path)
		i.audPlayer.stream = load(path)


func _on_CManButton_toggled(button_pressed):
	if button_pressed:
		replaceSongs(jokeSongsC)
	elif !button_pressed:
		replaceSongs(jokeSongsB)


func _on_jokeButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		jokeBeats += 1
		if jokeBeats == 4 && camera.zoom == Vector2(1,1):
			var tween = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
			tween.tween_property(camera, "zoom", Vector2(1.25,1.25), 2.0)
	else:
		jokeBeats -= 1
