extends "res://scenes/pet.gd"

func _ready():
	spriteTexture = "res://assets/sprites/pets/pink/baby.png"
	self.texture = load(spriteTexture)

func update_pet_sprite():
	if pet.pet.size <= 2:
		if pet.pet.happiness < 5:
			spriteTexture = "res://assets/sprites/pets/pink/babyAngry.png"
			pet.petSprite = "res://assets/sprites/pets/pink/babyAngry.png"
	if pet.pet.size == 3:
		if pet.pet.happiness < 5:
			spriteTexture = "res://assets/sprites/pets/pink/phase2Angry.png"
			pet.petSprite = "res://assets/sprites/pets/pink/phase2Angry.png"
		else:
			spriteTexture = "res://assets/sprites/pets/pink/phase2.png"
			pet.petSprite = "res://assets/sprites/pets/pink/phase2.png"

	elif pet.pet.size == 4:
		if pet.pet.happiness < 5:
			spriteTexture = "res://assets/sprites/pets/pink/phase3Angry.png"
			pet.petSprite = "res://assets/sprites/pets/pink/phase3Angry.png"
		else:
			spriteTexture = "res://assets/sprites/pets/pink/phase3.png"
			pet.petSprite = "res://assets/sprites/pets/pink/phase3.png"

	elif pet.pet.size == 5:
		if pet.pet.happiness < 5:
			spriteTexture = "res://assets/sprites/pets/pink/phase4Angry.png"
			pet.petSprite = "res://assets/sprites/pets/pink/phase4Angry.png"
		else:
			spriteTexture = "res://assets/sprites/pets/pink/phase4.png"
			pet.petSprite = "res://assets/sprites/pets/pink/phase4.png"

	self.texture = load(spriteTexture)