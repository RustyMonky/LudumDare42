extends Sprite

var animationPlayer
var particles
var spriteTexture

func _ready():
	animationPlayer = $animation
	particles = $particles

func explode():
	animationPlayer.play("explode")
