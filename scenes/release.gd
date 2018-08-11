extends Node

var gradeGrid
var gradeSprite
var gradeTween
var mainFont
var petSprite
var totalTween

func _ready():
	gradeGrid = $canvas/gradeGrid
	gradeSprite = $gradeSprite
	gradeTween = $gradeTween
	mainFont = load("res://assets/fonts/main.tres")
	petSprite = $petSprite
	totalTween = $totalTween

	petSprite.set_texture(load(pet.petSprite))

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

func evaluate_score():
	var score = (pet.pet.happiness + pet.pet.hunger + pet.pet.size) / 3
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
