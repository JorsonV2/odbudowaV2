extends building

# Called when the node enters the scene tree for the first time.
func _ready():
	if game_controller.guard_rescued:
		rescue = true
	else:
		rescue = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
