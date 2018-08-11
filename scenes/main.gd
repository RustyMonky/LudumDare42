extends Node

var actionsMenu
var ageProgress
var happyProgress
var hungerProgress
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
	petSprite = $pet
	sizeProgress = $ui/statusGrid/sizeProgress
	statusTween = $ui/statusGrid/statusTween
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
		update_status_bars()
		gameState.currentState = gameState.PROMPT

func prepare_text_queue(textArray, textIndex):
	textIsDone = false
	textQueue = textArray
	textQueueIndex = textIndex
	textLabel.set_text(textArray[textIndex])
	textLabel.set_visible_characters(0)

func update_pet_sprite():
	if pet.pet.size == 3:
		var spriteTexture = load("res://assets/sprites/pets/phase2.png")
		petSprite.set_texture(spriteTexture)
	elif pet.pet.size == 4:
		var spriteTexture = load("res://assets/sprites/pets/phase3.png")
		petSprite.set_texture(spriteTexture)
	elif pet.pet.size == 5:
		var spriteTexture = load("res://assets/sprites/pets/phase4.png")
		petSprite.set_texture(spriteTexture)

func update_status_bars():
	if sizeProgress.get_value() != pet.pet.size:
		update_pet_sprite()
		statusTween.interpolate_property(sizeProgress, "value", sizeProgress.get_value(), pet.pet.size, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)

	if happyProgress.get_value() != pet.pet.happiness:
		statusTween.interpolate_property(happyProgress, "value", happyProgress.get_value(), pet.pet.happiness, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)

	if hungerProgress.get_value() != pet.pet.hunger:
		statusTween.interpolate_property(hungerProgress, "value", hungerProgress.get_value(), pet.pet.hunger, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)

	statusTween.interpolate_property(ageProgress, "value", ageProgress.get_value(), pet.pet.age, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)

	statusTween.start()

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
