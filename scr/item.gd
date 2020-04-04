extends RigidBody2D

class_name item

var item_name = "bambus"
var drag_distance = 150
var player

func _ready():
	player = game_controller.player
	get_node("Sprite").texture = load("res://gfx/items/" + item_name + ".png")
			
	pass # Replace with function body.

func _process(delta):
	if player != null:
		if global_position.distance_to(player.global_position) < drag_distance:
			linear_velocity = global_position.direction_to(player.global_position) * 200
	pass
	
func collected():
	signals.emit_collect_item(item_name)
	queue_free()
	pass
