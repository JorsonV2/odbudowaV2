extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func save_the_game():
	var dictionary = {
		"player_position_x" : game_controller.player.global_position.x,
		"player_position_y" : game_controller.player.global_position.y,
		"player_health" : game_controller.player.health,
		"player_equipment" : game_controller.player_equipment,
		"current_map" : get_tree().get_root().get_node("map").map_name,
		"meteor_fallen" : game_controller.meteor_fallen,
		"activated_buildings" : game_controller.activated_buildings,
		"current_mission" : 
			{"id" : 0, "tasks" : {}}	
		}
	dictionary["current_mission"]["id"] = mission_controller.current_mission_id
	for t in range(0, mission_controller.current_mission.tasks.size()):
		dictionary["current_mission"]["tasks"][t] = {"completed" : mission_controller.current_mission.tasks[t].completed, "current_amount" : mission_controller.current_mission.tasks[t].current_amount}
		pass
	print_debug(to_json(dictionary))
	var save_file = File.new()
	save_file.open("user://villagereborn.save", File.WRITE)
	save_file.store_string(to_json(dictionary))
	save_file.close()
	pass
