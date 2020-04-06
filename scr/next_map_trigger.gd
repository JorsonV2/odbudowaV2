extends Area2D

export var map_text = "map_text"
export var map_name = "map_name"
export var trigger_side = "left"
var time_delay =0.5

func _ready():
	if trigger_side == "right":
		get_node("Sprite").flip_h =true
	$Label.text = map_text
	pass # Replace with function body.

func _on_next_map_trigger_area_entered(area):
	if area.is_in_group("player"):
		var new_map
		var old_map
		
		match map_name:
			"village":
				new_map = game_controller.village_scene.instance()
			"forest":
				new_map = game_controller.forest_scene.instance()
			"deep_forest":
				new_map = game_controller.deep_forest_scene.instance()
			"forest_right":
				new_map = game_controller.forest_right_scene.instance()
			"savage_village":
				new_map = game_controller.savage_village_scene.instance()
			
		if trigger_side == "left":
			game_controller.player_destination = "right"
		else:
			game_controller.player_destination = "left"
				
		old_map = get_tree().get_root().get_node("map")
		old_map.set_name("map1")	
		
		#yield(get_tree().create_timer(time_delay), "timeout")
		game_controller.game_stop = true
		game_controller.fade_animation.show()
		game_controller.fade_animation.play_fade()
		yield(game_controller.fade_animation.animation_player, "animation_finished")
		
		get_tree().get_root().call_deferred("add_child", new_map)
		new_map.set_name("map")
		old_map.hide()
		
		game_controller.game_stop = false
		game_controller.fade_animation.play_backwards_fade()
		yield(game_controller.fade_animation.animation_player, "animation_finished")
		game_controller.fade_animation.hide()
		
		signals.emit_mission_task("place", map_name)
		old_map.queue_free()
	
		pass
	pass # Replace with function body.
