extends Node

signal collect_item(item)
signal update_equipment(equipment)
signal update_health(health)
signal mission_task(type, object)
signal update_current_mission()
signal spawn_player()
signal mission_trigger(trigger)
signal mission_completed()
signal add_map()

func _ready():
	pass

func emit_collect_item(item):
	emit_signal("collect_item", item)
	
func emit_update_equipment(equipment):
	emit_signal("update_equipment", equipment)
	game_controller.in_game_ui.update_equipment()
	emit_mission_task("resource", "gold")
	emit_mission_task("resource", "wood")
	emit_mission_task("resource", "rock")
	emit_mission_task("resource", "leather")

func emit_update_health(health):
	emit_signal("update_health", health)
	
func emit_mission_task(type, object):
	emit_signal("mission_task", type, object)

func emit_update_current_mission():
	emit_signal("update_current_mission")
	
func emit_spawn_player():
	emit_signal("spawn_player")
	
func emit_mission_trigger(trigger):
	emit_signal("mission_trigger", trigger)
	pass

func emit_mission_complete():
	emit_signal("mission_completed")
	pass
	
func emit_add_map():
	emit_signal("add_map")
	pass
