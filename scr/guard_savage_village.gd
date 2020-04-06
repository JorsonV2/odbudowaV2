extends AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	if mission_controller.current_mission != null:
		if mission_controller.current_mission.tasks[0].object == "guard":
			show()
		else:
			hide()
	else:
		hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
