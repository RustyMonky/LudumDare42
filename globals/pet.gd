extends Node

var isDead = false

var pet = {
	age = 0,
	happiness = 5,
	hunger = 5,
	size = 0
}

var petSprite = "res://assets/sprites/pets/pink/baby.png"

func feed():
	pet.hunger += 1
	pet.size += 2
	pet.happiness += 1
	result()

func play():
	pet.happiness += 2
	pet.hunger += 1
	pet.size += 1
	result()

func scold():
	pet.happiness -= 3
	pet.hunger -= 1
	if pet.size -1 <= 0:
		pet.size = 0
	else:
		pet.size -= 1
	result()

func release():
	pass

func result():
	var textQueue = []
	pet.age += 1

	if pet.happiness <= 0:
		textQueue.append("It's got so angry...")
		textQueue.append("...that it exploded!")
		textQueue.append("How sad. You monster.")
		isDead = true

	if pet.size > 5:
		textQueue.append("You've overfed the creature.")
		textQueue.append("You ran out of space to fit it...")
		textQueue.append("...and it exploded.")
		textQueue.append("I hope you're happy...")
		isDead = true

	if !isDead:
		if pet.size <= 2:
			textQueue.append("It's a healthy size...")
			textQueue.append("...for now.")
		elif pet.size == 3:
			textQueue.append("It's growing large...")
		elif pet.size == 4:
			textQueue.append("It barely fits in here!")
		elif pet.size == 5:
			textQueue.append("There's no room for it to fit!")
			textQueue.append("Quick, slim it down!")
		elif pet.size > 5:
			textQueue.append("You've overfed the creature.")
			textQueue.append("You ran out of space to fit it...")
			textQueue.append("...and it exploded.")
			textQueue.append("I hope you're happy...")
			isDead = true

		if pet.happiness < 5:
			textQueue.append("It's angry!")
		elif pet.happiness >= 5:
			textQueue.append("It's happy.")

		if pet.hunger < 5:
			textQueue.append("It's hungry!")
		elif pet.hunger >= 5:
			textQueue.append("It's well fed.")

		if pet.age == 2:
			textQueue.append("It's still young.")
		elif pet.age == 4:
			textQueue.append("It's adolescent.")
		elif pet.age == 6:
			textQueue.append("It's an adult now!")
		elif pet.age == 8:
			textQueue.append("It's getting old...")
		elif pet.age == 10:
			textQueue.append("It's too old...")

			textQueue.append("What will you do?")

	gameState.currentState = gameState.RESULT
	print(pet)
	return textQueue
