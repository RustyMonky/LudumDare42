extends "res://scenes/pet.gd"

func _ready():
	spriteTexture = "res://assets/sprites/pets/pink/baby.png"
	self.texture = load(spriteTexture)

func update_pet_sprite():
	if pet.pet.size <= 2:
		if pet.pet.happiness < 5:
			spriteTexture = "res://assets/sprites/pets/pink/babyAngry.png"
			pet.petSprite = spriteTexture
	elif pet.pet.size == 3:
		if pet.pet.happiness < 5:
			spriteTexture = "res://assets/sprites/pets/pink/phase2Angry.png"
			pet.petSprite = spriteTexture
		else:
			spriteTexture = "res://assets/sprites/pets/pink/phase2.png"
			pet.petSprite = spriteTexture

	elif pet.pet.size == 4:
		if pet.pet.happiness < 5:
			spriteTexture = "res://assets/sprites/pets/pink/phase3Angry.png"
			pet.petSprite = spriteTexture
		else:
			spriteTexture = "res://assets/sprites/pets/pink/phase3.png"
			pet.petSprite = spriteTexture

	elif pet.pet.size == 5:
		if pet.pet.happiness < 5:
			spriteTexture = "res://assets/sprites/pets/pink/phase4Angry.png"
			pet.petSprite = spriteTexture
		else:
			spriteTexture = "res://assets/sprites/pets/pink/phase4.png"
			pet.petSprite = spriteTexture

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