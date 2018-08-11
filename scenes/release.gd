extends Node

var gradeGrid
var gradeSprite
var gradeTween
var isResultTextDone = false
var mainFont
var petSprite
var resultTextbox
var resultTextLabel
var resultTween
var score
var totalTween

func _ready():
	gradeGrid = $gradeCanvas/gradeGrid
	gradeSprite = $gradeSprite
	gradeTween = $gradeTween
	mainFont = load("res://assets/fonts/main.tres")
	petSprite = $petSprite
	resultTextbox = $resultCanvas/resultTextbox
	resultTextLabel = $resultCanvas/resultTextbox/resultText
	resultTween = $resultCanvas/resultTween
	totalTween = $totalTween

	petSprite.set_texture(load(pet.petSprite))
	var spriteSize = petSprite.get_texture().get_size()
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

func determine_result_text():
	var result = ""
	if pet.pet.age <= 2:
		result += "You released it during its youth.\n"
	elif pet.pet.age <= 4:
		result += "You released it, fully grown.\n"
	elif pet.pet.age <= 6:
		result += "You released it past its prime.\n"
	elif pet.pet.age <= 8:
		result += "You released it during its waning years.\n"
	elif pet.pet.age <= 10:
		result += "You released it out into the world, though it won't last much longer.\n"

	if pet.pet.size <= 2 :
		result += "With its small stature, it won't stand out.\n"
	elif pet.pet.size == 3:
		result += "It was rather large, and can probably handle itself.\n"
	elif pet.pet.size == 4:
		result += "It was overweight, but you let it go anyway.\n"
	elif pet.pet.size == 5:
		result += "You pratically rolled it out. It was massive!\n"

	if pet.pet.happiness < 5:
		result += "It was still angry when it left...and could be dangerous.\n"
	else:
		result += "You cared for it well, and it was sad to leave you.\n"

	if score <= 3:
		result += "You could probably have cared for it better..."
	elif score <= 6:
		result += "You did the best you could for it."
	elif score <= 8:
		result += "You nurtured it well. Good job!"
	elif score <= 10:
		result += "You couldn't have done a better job!"

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
	resultTween.interpolate_property(resultTextbox, "visible", false, true, 3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	resultTween.start()
