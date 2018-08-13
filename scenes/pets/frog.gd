extends "res://scenes/pet.gd"

func _ready():
	spriteTexture = "res://assets/sprites/pets/frog/baby.png"
	self.texture = load(spriteTexture)

func update_pet_sprite():
	if pet.pet.size < 3:
		if pet.pet.happiness < 5:
			spriteTexture = "res://assets/sprites/pets/frog/babyAngry.png"
			pet.petSprite = spriteTexture
		else:
			spriteTexture = "res://assets/sprites/pets/frog/baby.png"
			pet.petSprite = spriteTexture
	elif pet.pet.size >= 3:
		if pet.pet.happiness < 5:
			spriteTexture = "res://assets/sprites/pets/frog/fatAngry.png"
			pet.petSprite = spriteTexture
		else:
			spriteTexture = "res://assets/sprites/pets/frog/fat.png"
			pet.petSprite = spriteTexture

	self.texture = load(spriteTexture)

func _on_animation_animation_finished(anim_name):
	self.texture = null

	if pet.pet.size < 3:
		particles.amount = 256
	else:
		particles.amount = 4096

	particles.set_emitting(true)
