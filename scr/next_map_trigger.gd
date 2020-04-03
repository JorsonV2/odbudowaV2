extends Area2D

export var map_name = "map_name"
export var trigger_side = "left"
func _ready():
	pass # Replace with function body.

func _on_next_map_trigger_area_entered(area):
	if area.is_in_group("player"):
		var new_map
		match map_name:
			"village":
				new_map = game_controller.village_scene.instance()
			"forest":
				new_map = game_controller.forest_scene.instance()
			"deep_forest":
				new_map = game_controller.deep_forest_scene.instance()
		var old_map = get_tree().get_root().get_node("map")
		old_map.set_name("map1")
		get_tree().get_root().call_deferred("add_child", new_map)
		new_map.set_name("map")
		old_map.queue_free()
		
		if trigger_side == "left":
			game_controller.player_destination = "right"
		else:
			game_controller.player_destination = "left"
		
		pass
	pass # Replace with function body.
