extends "res://scenes/pet.gd"

func _ready():
	spriteTexture = "res://assets/sprites/pets/penguin/baby.png"
	self.texture = load(spriteTexture)

func update_pet_sprite():
	if pet.pet.size == 3:
		if pet.pet.happiness < 5:
			spriteTexture = "res://assets/sprites/pets/penguin/phase2Angry.png"
			pet.petSprite = "res://assets/sprites/pets/penguin/phase2Angry.png"
		else:
			spriteTexture = "res://assets/sprites/pets/penguin/phase2.png"
			pet.petSprite = "res://assets/sprites/pets/penguin/phase2.png"

	elif pet.pet.size == 4:
		if pet.pet.happiness < 5:
			spriteTexture = "res://assets/sprites/pets/penguin/phase3Angry.png"
			pet.petSprite = "res://assets/sprites/pets/penguin/phase3Angry.png"
		else:
			spriteTexture = "res://assets/sprites/pets/penguin/phase3.png"
			pet.petSprite = "res://assets/sprites/pets/penguin/phase3.png"

	elif pet.pet.size == 5:
		if pet.pet.happiness < 5:
			spriteTexture = "res://assets/sprites/pets/penguin/phase4Angry.png"
			pet.petSprite = "res://assets/sprites/pets/penguin/phase4Angry.png"
		else:
			spriteTexture = "res://assets/sprites/pets/penguin/phase4.png"
			pet.petSprite = "res://assets/sprites/pets/penguin/phase4.png"

	self.texture = load(spriteTexture)