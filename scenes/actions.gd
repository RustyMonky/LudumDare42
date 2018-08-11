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

func _on_scoldButton_pressed():
	pet.scold()
	self.hide()

func _on_releaseButton_pressed():
	pass