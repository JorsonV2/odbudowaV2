extends RigidBody2D

class_name item

var item_name = "bambus"
var drag_distance = 150
var player
var fallen = false

func _ready():
	player = game_controller.player
	get_node("Sprite").texture = load("res://gfx/items/" + item_name + ".png")
			
	pass # Replace with function body.

func _process(delta):
	if linear_velocity.y == 0:
		fallen = true
	if player != null and fallen and not game_controller.player_dead:
		if global_position.distance_to(player.global_position) < drag_distance:
			linear_velocity = global_position.direction_to(player.global_position) * 300
	pass
	
func collected():
	signals.emit_collect_item(item_name)
	queue_free()
	pass
