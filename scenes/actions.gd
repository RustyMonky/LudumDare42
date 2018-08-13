extends Control

func ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept") && gameState.currentState != gameState.ACTION:
		self.hide()
		pass

func _on_feedButton_pressed():
	pet.feed()
	self.hide()

func _on_playButton_pressed():
	pet.play()
	self.hide()

func _on_dietButton_pressed():
	pet.diet()
	self.hide()

func _on_releaseButton_pressed():
	sceneManager.goto_scene("res://scenes/release.tscn")
