extends animal

class_name rabbit
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func dead():
	
	.dead()
	signals.emit_mission_task("kill", "rabbit")
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):


	#pass
