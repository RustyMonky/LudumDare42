extends Node

var actionsMenu
var textIsDone = false
var textLabel
var textQueue = []
var textQueueIndex = 0
var textTimer
var transitionTimer

func _ready():
	actionsMenu = $actionsMenu/actions
	gameState.currentState = gameState.PROMPT
	textLabel = $ui/textbox/label
	textTimer = $ui/textbox/textTimer
	transitionTimer = $transitionTimer

	prepare_text_queue(["The creature is newly born.", "What do you do?"], 0)

	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if textIsDone && gameState.currentState != gameState.ACTION:
			changeState()
		elif textLabel.get_visible_characters() >= textLabel.get_total_character_count() && textQueue.size() > 0:
			prepare_text_queue(textQueue, textQueueIndex)

func changeState():
	if gameState.currentState == gameState.PROMPT && !pet.isDead:
		gameState.currentState = gameState.ACTION
		transitionTimer.start()

	elif gameState.currentState == gameState.PROMPT && pet.isDead:
		sceneManager.goto_scene("res://scenes/gameover.tscn")

	elif gameState.currentState == gameState.RESULT:
		prepare_text_queue(pet.result(), 0)
		gameState.currentState = gameState.PROMPT

func prepare_text_queue(textArray, textIndex):
	textIsDone = false
	textQueue = textArray
	textQueueIndex = textIndex
	textLabel.set_text(textArray[textIndex])
	textLabel.set_visible_characters(0)

func _on_textTimer_timeout():
	var visibleText = textLabel.get_visible_characters()
	textLabel.set_visible_characters(visibleText + 1)

	if visibleText == textLabel.get_total_character_count():
		if textQueueIndex < (textQueue.size() - 1):
			textQueueIndex += 1
		else:
			textIsDone = true

func _on_transitionTimer_timeout():
	actionsMenu.show()
