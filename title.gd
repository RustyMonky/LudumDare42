extends Node

var background
var titleMusic
var titleTween

func _ready():
	background = $background
	titleMusic = $titleMusic
	titleTween = $titleTween

func _on_start_pressed():
	titleTween.interpolate_property(background, "modulate", Color(1,1,1,1), Color(0,0,0,1), 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	titleTween.interpolate_property(titleMusic, "volume_db", -10, -20, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	titleTween.start()

func _on_titleTween_tween_completed(object, key):
	sceneManager.goto_scene("res://scenes/info.tscn")
