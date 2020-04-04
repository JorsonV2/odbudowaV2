extends Node

var current_mission : mission
var missions = []

func _ready():
	signals.connect("mission_task", self, "mission_task")
	add_missions()
	pass # Replace with function body.

func add_missions():
	var new_mission = mission.new("meteor")
	new_mission.add_task("Kill rabbits", "kill", "rabbit", 6)
	new_mission.active = true
	current_mission = new_mission
	var next_mission = mission.new()
	next_mission.add_task("Kill animals", "kill", "animal", 10)
	next_mission.add_task("Kill rabbits", "kill", "rabbit", 5)
	new_mission.next_mission = next_mission
	pass

func mission_task(type, object):
	if current_mission != null:
		current_mission.mission_task(type, object)
		if current_mission.completed:
			if current_mission.next_mission == null:
				current_mission = null
			else:
				current_mission = current_mission.next_mission
			signals.emit_update_current_mission()
	pass
