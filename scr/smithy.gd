extends building


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if game_controller.blacksmith_rescued:
		rescue = true
	else:
		rescue = false
	pass # Replace with function body.
	
func action():
	.action()
	game_controller.player.first_weapon_damage += 5
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_action_buton_pressed():
	action()
	pass # Replace with function body.
