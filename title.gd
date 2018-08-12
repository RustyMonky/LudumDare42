extends Node

func _ready():
	pass

func _on_start_pressed():
	sceneManager.goto_scene("res://scenes/info.tscn")
