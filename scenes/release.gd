extends Node

enum resultState { GRADE, TEXT }

var currentState
var gradeGrid
var gradeSprite
var gradeTween
var isResultTextDone = false
var mainFont
var petSprite
var petSpriteTexture
var resultTextbox
var resultTextLabel
var resultTween
var score
var totalTween

func _ready():
	currentState = resultState.GRADE
	gradeGrid = $gradeCanvas/gradeGrid
	gradeSprite = $gradeSprite
	gradeTween = $gradeTween
	mainFont = load("res://assets/fonts/main.tres")
	petSprite = $petSprite
	resultTextbox = $resultCanvas/resultTextbox
	resultTextLabel = $resultCanvas/resultTextbox/resultText
	resultTween = $resultCanvas/resultTween
	totalTween = $totalTween

	petSpriteTexture = load(pet.petSprite)
	petSprite.set_texture(petSpriteTexture)
	var spriteSize = petSpriteTexture.get_size()
	petSprite.position = Vector2(160 - spriteSize.x, 144 - (spriteSize.y / 2))

	for key in pet.pet.keys():
		if key == "age":
			pass
		var keyLabel = Label.new()
		keyLabel.set_text(key)
		keyLabel.set("custom_fonts/font", mainFont)

		var gradeLabel = Label.new()
		gradeLabel.set_text(String(pet.pet[key]))
		gradeLabel.set("custom_fonts/font", mainFont)
		gradeLabel.set_align(Label.ALIGN_RIGHT)
		gradeLabel.set("rect_min_size", Vector2(40, 16))

		gradeGrid.add_child(keyLabel)
		gradeGrid.add_child(gradeLabel)

	gradeTween.interpolate_property(gradeGrid, "rect_position", gradeGrid.rect_position, Vector2(10, 16), 1.5, Tween.TRANS_BOUNCE, Tween.EASE_IN)

	gradeTween.start()

	evaluate_score()

	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept") && currentState == resultState.TEXT:
		pet.reset_pet_values()
		sceneManager.goto_scene("res://scenes/main.tscn")

func determine_result_text():
	var result = ""
	if pet.pet.age <= 2:
		result += "It was barely a child when you let it go.\n"
	elif pet.pet.age <= 4:
		result += "It left you as an adolscent, still growing.\n"
	elif pet.pet.age <= 6:
		result += "You released it, fully grown.\n"
	elif pet.pet.age <= 8:
		result += "It left you, past its prime.\n"
	elif pet.pet.age <= 10:
		result += "You let it go, but it doesn't have long.\n"

	if pet.pet.size <= 2 :
		result += "It was so small...\n"
	elif pet.pet.size == 3:
		result += "Its size was impressive, but not extraordinary.\n"
	elif pet.pet.size == 4:
		result += "It was overweight, thanks to you.\n"
	elif pet.pet.size == 5:
		result += "It had to go -- you had no room left for it!\n"

	if pet.pet.happiness < 5:
		result += "It was still angry when it left...\n"
	else:
		result += "It seemed happy, thanks to you.\n"

	if score <= 3:
		result += "Yet you could've done better..."
	elif score <= 6:
		result += "You did the best you could."
	elif score <= 8:
		result += "You nurtured it well."
	elif score <= 10:
		result += "Clearly, you know what you're doing."

	resultTextLabel.set_text(result)

func evaluate_score():
	score = (pet.pet.happiness + pet.pet.hunger + pet.pet.size) / 3
	if score <= 3:
		gradeSprite.set_texture(load("res://assets/sprites/grades/c.png"))
	elif score <= 6:
		gradeSprite.set_texture(load("res://assets/sprites/grades/b.png"))
	elif score <= 9:
		gradeSprite.set_texture(load("res://assets/sprites/grades/a.png"))
	else:
		gradeSprite.set_texture(load("res://assets/sprites/grades/s.png"))

func _on_gradeTween_tween_completed(object, key):
	totalTween.interpolate_property(gradeSprite, "position", gradeSprite.position, Vector2(32, 124), 1.5, Tween.TRANS_BACK, Tween.EASE_IN)
	totalTween.start()

func _on_totalTween_tween_completed(object, key):
	determine_result_text()
	resultTween.interpolate_property(resultTextbox, "visible", false, true, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	resultTween.start()

func _on_resultTween_tween_completed(object, key):
	currentState = resultState.TEXT
