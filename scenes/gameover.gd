extends Node

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_retryButton_pressed():
	pet.reset_pet_values()
	sceneManager.goto_scene("res://scenes/main.tscn")
