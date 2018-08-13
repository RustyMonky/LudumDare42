extends Node

var background
var click
var startButton
var titleMusic
var titleTween

func _ready():
	background = $background
	click = $background/start/click
	startButton = $background/start
	titleMusic = $titleMusic
	titleTween = $titleTween

func _on_start_pressed():
	startButton.disabled = true
	click.play()
	titleTween.interpolate_property(background, "modulate", Color(1,1,1,1), Color(0,0,0,1), 1.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	titleTween.interpolate_property(titleMusic, "volume_db", -10, -20, 1.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	titleTween.start()

func _on_titleTween_tween_completed(object, key):
	sceneManager.goto_scene("res://scenes/info.tscn")
