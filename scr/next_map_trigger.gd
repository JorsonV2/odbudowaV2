extends Area2D

export var map_name = "map_name"
export var trigger_side = "left"
var time_delay =0.5

var animation_map 
var black

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
		
		game_controller.scene_changer.get_node("Control").show()
		animation_map = game_controller.scene_changer.find_node("animation_map")
		black = game_controller.scene_changer.find_node("panel_black")
		#yield(get_tree().create_timer(time_delay), "timeout")
		game_controller.player.active_move=false
		animation_map.play("fade")
		yield(animation_map,"animation_finished")
		
		
		get_tree().get_root().call_deferred("add_child", new_map)
		new_map.set_name("map")
		game_controller.player.active_move=true
		animation_map.play_backwards("fade")
		
		old_map.queue_free()
		yield(animation_map,"animation_finished")
		
		if trigger_side == "left":
			game_controller.player_destination = "right"
		else:
			game_controller.player_destination = "left"
		
		
		
		pass
	pass # Replace with function body.
