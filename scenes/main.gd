extends Node

var textIsDone = false
var textLabel
var textQueue = []
var textQueueIndex = 0
var textTimer

func _ready():
	textLabel = $ui/textbox/label
	textTimer = $ui/textbox/textTimer

	prepare_text_queue(["This is a test...", "Does it work?"], 0)

	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if textIsDone:
			pass
		elif textLabel.get_visible_characters() >= textLabel.get_total_character_count():
			prepare_text_queue(textQueue, textQueueIndex)

func prepare_text_queue(textArray, textIndex):
	textQueue = textArray
	textQueueIndex = textIndex
	textLabel.set_text(textArray[textIndex])
	textLabel.set_visible_characters(0)
	textIsDone = false

func _on_textTimer_timeout():
	var visibleText = textLabel.get_visible_characters()
	textLabel.set_visible_characters(visibleText + 1)

	if visibleText == textLabel.get_total_character_count():
		if textQueueIndex < (textQueue.size() - 1):
			textQueueIndex += 1
		else:
			textIsDone = true
