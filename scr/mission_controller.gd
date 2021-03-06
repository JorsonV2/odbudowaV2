extends Node

var current_mission : mission
var current_mission_id = 0
var missions = []


func _ready():
	signals.connect("mission_task", self, "mission_task")
	
	add_missions()
	pass # Replace with function body.

func add_missions():
	missions = []
	current_mission_id = 0
	var new_mission
	new_mission = mission.new()
	new_mission.add_task("W sumie to gadasz ze sobą xD", "talk", "self",  1)
	add_mission_to_table(new_mission)
	current_mission = new_mission

	new_mission = mission.new()
	new_mission.add_task("Udaj się na polowanie do lasu", "place", "forest", 1)
	add_mission_to_table(new_mission)

	new_mission = mission.new()
	new_mission.add_task("Upoluj 10 królików", "kill", "rabbit", 10)
	add_mission_to_table(new_mission)

	new_mission = mission.new("meteor")
	new_mission.add_task("Upoluj 6 lisów", "kill", "fox", 6)
	add_mission_to_table(new_mission)

	new_mission = mission.new()
	new_mission.add_task("Sprawdź co stało się z miastem", "place", "village", 1)
	add_mission_to_table(new_mission)

	new_mission = mission.new()
	new_mission.add_task("Porozmawiaj z nieznajomym", "talk", "tradesman", 1)
	add_mission_to_table(new_mission)

	new_mission = mission.new()
	new_mission.add_task("Sprawdź co stało się z twoim domem", "place", "Dom", 1)
	add_mission_to_table(new_mission)
	
	new_mission = mission.new()
	new_mission.add_task("Uzbieraj 10 złota", "resource", "gold", 10)
	new_mission.add_task("Uzbieraj 10 drewna", "resource", "wood", 10)
	new_mission.add_task("Uzbieraj 10 kamienia", "resource", "rock", 10)
	add_mission_to_table(new_mission)
	
	new_mission = mission.new()
	new_mission.add_task("Odbuduj swój dom", "build", "Dom", 1)
	add_mission_to_table(new_mission)
	
	new_mission = mission.new()
	new_mission.add_task("Zwiększ swoje zdrowie", "action", "Dom", 4)
	add_mission_to_table(new_mission)
	
	new_mission = mission.new()
	new_mission.add_task("Dostań się do głębokiego lasu", "place", "deep_forest", 1)
	add_mission_to_table(new_mission)
	
	new_mission = mission.new("find_smith")
	new_mission.add_task("Odnajdź kowala", "talk", "smith", 1)
	add_mission_to_table(new_mission)
	
	new_mission = mission.new()
	new_mission.add_task("Uzbieraj 25 złota", "resource", "gold", 25)
	new_mission.add_task("Uzbieraj 25 drewna", "resource", "wood", 25)
	new_mission.add_task("Uzbieraj 50 kamienia", "resource", "rock", 50)
	new_mission.add_task("Uzbieraj 25 skór", "resource", "leather", 25)
	add_mission_to_table(new_mission)
	
	new_mission = mission.new()
	new_mission.add_task("Odbuduj kuźnię", "build", "Kuźnia", 1)
	add_mission_to_table(new_mission)
	
	new_mission = mission.new()
	new_mission.add_task("Ulepsz obrażenia broni", "action", "Kuźnia", 2)
	add_mission_to_table(new_mission)
	
	new_mission = mission.new()
	new_mission.add_task("Dostań się na tereny dzikusów", "place", "savage_village", 1)
	add_mission_to_table(new_mission)
	
	new_mission = mission.new("find_guard")
	new_mission.add_task("Odnajdź strażnika", "talk", "guard", 1)
	add_mission_to_table(new_mission)
	
	new_mission = mission.new()
	new_mission.add_task("Uzbieraj 50 złota", "resource", "gold", 50)
	new_mission.add_task("Uzbieraj 50 drewna", "resource", "wood", 50)
	new_mission.add_task("Uzbieraj 100 kamienia", "resource", "rock", 100)
	new_mission.add_task("Uzbieraj 10 skór", "resource", "leather", 10)
	add_mission_to_table(new_mission)
	
	new_mission = mission.new()
	new_mission.add_task("Odbuduj wieżę", "build", "Wieża", 1)
	add_mission_to_table(new_mission)
	
	new_mission = mission.new()
	new_mission.add_task("Ulepsz prędkość biegania", "action", "Wieża", 4)
	add_mission_to_table(new_mission)
	
	pass

func add_mission_to_table(added_mission):
	if missions.size() == 0:
		missions.append(added_mission)
	else:
		missions[missions.size() - 1].next_mission = added_mission
		missions.append(added_mission)
	pass

func mission_task(type, object):
	if current_mission != null:
		current_mission.mission_task(type, object)
		if current_mission.completed:
			
			if current_mission.next_mission == null:
				current_mission = null
				signals.emit_win()
			else:
				current_mission = current_mission.next_mission
				current_mission_id += 1
			signals.emit_update_current_mission()
			signals.emit_update_equipment(game_controller.player_equipment)
	pass
	
