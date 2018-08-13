extends Control

var click

func _ready():
	click = $click
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept") && gameState.currentState != gameState.ACTION:
		self.hide()
		pass

func _on_feedButton_pressed():
	click.play()
	pet.feed()
	self.hide()

func _on_playButton_pressed():
	click.play()
	pet.play()
	self.hide()

func _on_dietButton_pressed():
	click.play()
	pet.diet()
	self.hide()

func _on_releaseButton_pressed():
	sceneManager.goto_scene("res://scenes/release.tscn")
