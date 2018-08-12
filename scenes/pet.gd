extends Sprite

var animationPlayer
var spriteTexture

func _ready():
	animationPlayer = $animation

func explode():
	animationPlayer.play("explode")
