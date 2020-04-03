extends savage

class_name spear_man
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

		
func flip_enemy():
	.flip_enemy()
	$animated_sprite.offset.x = -$animated_sprite.offset.x
	pass
