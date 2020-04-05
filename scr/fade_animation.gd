extends CanvasLayer

class_name fade_animation
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var animation_player
var animation_panels

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = get_node("animation_player")
	animation_panels = get_node("animation_panels")
	pass # Replace with function body.

func play_fade():
	animation_player.play("fade")
	pass
	
func play_backwards_fade():
	animation_player.play_backwards("fade")
	pass
	
func hide():
	animation_panels.hide()
	pass

func show():
	animation_panels.show()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
