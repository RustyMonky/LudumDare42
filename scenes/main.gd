extends Node

var actionsMenu
var ageProgress
var happyProgress
var hungerProgress
var nextButton
var petSprite
var sizeProgress
var statusTween
var textIsDone = false
var textLabel
var textQueue = []
var textQueueIndex = 0
var textTimer
var transitionTimer

func _ready():
	actionsMenu = $actionsMenu/actions
	ageProgress = $ui/statusGrid/ageProgress
	gameState.currentState = gameState.PROMPT
	happyProgress = $ui/statusGrid/happyProgress
	hungerProgress = $ui/statusGrid/hungerProgress
	nextButton = $ui/textbox/nextButton
	sizeProgress = $ui/statusGrid/sizeProgress
	statusTween = $ui/statusGrid/statusTween
	textLabel = $ui/textbox/label
	textTimer = $ui/textbox/textTimer
	transitionTimer = $transitionTimer

	pet.set_pet()
	petSprite = load("res://scenes/pets/" + pet.currentPet + ".tscn").instance()
	self.add_child(petSprite)

	prepare_text_queue(["The creature is newly born.", "What do you do?"], 0)

	set_process(true)

	set_process_input(true)

func _process(delta):
	if gameState.currentState == gameState.RESULT && textIsDone:
		if pet.isDead:
			petSprite.explode()
		prepare_text_queue(pet.result(), 0)
		update_status_bars()
		petSprite.update_pet_sprite()
		gameState.currentState = gameState.PROMPT

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if gameState.currentState == gameState.ACTION:
			return
		elif textIsDone:
			changeState()

func changeState():
	if gameState.currentState == gameState.PROMPT && !pet.isDead:
		gameState.currentState = gameState.ACTION
		transitionTimer.start()

	elif gameState.currentState == gameState.PROMPT && pet.isDead:
		sceneManager.goto_scene("res://scenes/gameover.tscn")

func prepare_text_queue(textArray, textIndex):
	textIsDone = false
	textQueue = textArray
	textQueueIndex = textIndex
	textLabel.set_text(textArray[textIndex])
	textLabel.set_visible_characters(0)

func update_status_bars():
	if sizeProgress.get_value() != pet.pet.size:
		statusTween.interpolate_property(sizeProgress, "value", sizeProgress.get_value(), pet.pet.size, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)

	if happyProgress.get_value() != pet.pet.happiness:
		statusTween.interpolate_property(happyProgress, "value", happyProgress.get_value(), pet.pet.happiness, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)

	if hungerProgress.get_value() != pet.pet.hunger:
		statusTween.interpolate_property(hungerProgress, "value", hungerProgress.get_value(), pet.pet.hunger, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)

	statusTween.interpolate_property(ageProgress, "value", ageProgress.get_value(), pet.pet.age, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)

	statusTween.start()

func _on_textTimer_timeout():
	var visibleText = textLabel.get_visible_characters()
	textLabel.set_visible_characters(visibleText + 1)

	if visibleText == textLabel.get_total_character_count():
		nextButton.show()
		if textQueueIndex < (textQueue.size() - 1):
			textQueueIndex += 1
		else:
			textIsDone = true

func _on_transitionTimer_timeout():
	actionsMenu.show()

func _on_nextButton_pressed():
	if !textIsDone:
		prepare_text_queue(textQueue, textQueueIndex)
	nextButton.hide()
