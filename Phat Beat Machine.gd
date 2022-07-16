extends Node2D

onready var mKnob = $mKnob

var mVol : bool = false
var iVol : bool = false
var rot = 0
var rott = 0
var rDiff = 180 / PI


func _ready():
	pass

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
