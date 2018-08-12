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

func _on_animation_animation_finished(anim_name):
	self.texture = null

	if pet.pet.size <= 2:
		particles.amount = 256
	elif pet.pet.size == 3:
		particles.amount = 1024
	elif pet.pet.size == 4:
		particles.amount = 2304
	elif pet.pet.size >= 5:
		particles.amount = 4096

	particles.set_emitting(true)
