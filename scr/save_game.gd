extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func delete_save():
	var file = File.new()
	if file.file_exists("user://villagereborn.save"):
		var dir = Directory.new()
		dir.remove("user://villagereborn.save")
		pass
	pass

func save_the_game():
	var dictionary = {
		"player_position_x" : game_controller.player.global_position.x,
		"player_position_y" : game_controller.player.global_position.y,
		"player_health" : game_controller.player.health,
		"player_max_health" : game_controller.player.max_health,
		"player_damage" : game_controller.player.first_weapon_damage,
		"player_movement_speed" : game_controller.player.movement_speed,
		"player_equipment" : game_controller.player_equipment,
		"current_map" : get_tree().get_root().get_node("map").map_name,
		"meteor_fallen" : game_controller.meteor_fallen,
		"activated_buildings" : game_controller.activated_buildings,
		"current_mission" : 
			{"id" : 0, "tasks" : []}	
		}
	dictionary["current_mission"]["id"] = mission_controller.current_mission_id
	for t in range(0, mission_controller.current_mission.tasks.size()):
		 dictionary.current_mission.tasks.append({"completed" : mission_controller.current_mission.tasks[t].completed, "current_amount" : mission_controller.current_mission.tasks[t].current_amount})
	print_debug(to_json(dictionary))
	var save_file = File.new()
	save_file.open("user://villagereborn.save", File.WRITE)
	save_file.store_string(to_json(dictionary))
	save_file.close()
	pass
	
func load_the_game():
	
	var save_file = File.new()
	save_file.open("user://villagereborn.save", File.READ)
	var save_dictionary = parse_json(save_file.get_as_text())
	save_file.close()
	
	var new_map
	var map_name = save_dictionary.current_map
	match map_name:
			"village":
				new_map = game_controller.village_scene.instance()
			"forest":
				new_map = game_controller.forest_scene.instance()
			"deep_forest":
				new_map = game_controller.deep_forest_scene.instance()
				
	game_controller.meteor_fallen = save_dictionary.meteor_fallen
	game_controller.activated_buildings = save_dictionary.activated_buildings
	
	if get_tree().get_root().has_node("lobby"):
		get_tree().get_root().get_node("lobby").queue_free()
	get_tree().get_root().call_deferred("add_child", new_map)
	
	yield(signals, "add_map")
	
	game_controller.player.position = Vector2(save_dictionary.player_position_x, save_dictionary.player_position_y)
	game_controller.player.health = save_dictionary.player_health
	game_controller.player.max_health = save_dictionary.player_max_health
	game_controller.player.first_weapon_damage = save_dictionary.player_damage
	game_controller.player.movement_speed = save_dictionary.player_movement_speed
	
	mission_controller.current_mission_id = save_dictionary.current_mission.id
	mission_controller.current_mission = mission_controller.missions[save_dictionary.current_mission.id]
	for t in range(0, save_dictionary.current_mission.tasks.size()):
		mission_controller.current_mission.tasks[t].current_amount = save_dictionary.current_mission.tasks[t].current_amount
		mission_controller.current_mission.tasks[t].completed = save_dictionary.current_mission.tasks[t].completed
	
	game_controller.player.equipment = save_dictionary.player_equipment
	signals.emit_update_equipment(game_controller.player.equipment)
