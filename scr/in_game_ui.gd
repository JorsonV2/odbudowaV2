extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var mission_scene

var animation_player
var mission_notification 

# Called when the node enters the scene tree for the first time.
func _ready():
	signals.connect("update_equipment", self, "update_equipment")
	signals.connect("update_health", self, "update_health")
	signals.connect("update_current_mission", self, "update_current_mission")
	animation_player = $animation_player
	mission_notification = find_node("mission_notification")
	update_current_mission()
	pass # Replace with function body.
	
func update_equipment(equipment):
	for e in range(0, equipment.size()):
		match e:
			0:
				find_node("gold_amound").text = String(equipment[e])
			1:
				find_node("wood_amound").text = String(equipment[e])
			2:
				find_node("rock_amound").text = String(equipment[e])
			3:
				find_node("leather_amound").text = String(equipment[e])
	#print_debug("ui ", equipment)
func update_health(health):
	find_node("health_bar").value = health 
	
func update_current_mission():
	var container = find_node("missions_container")
	for i in range(0, container.get_child_count()):
		if container.get_child(i).name != "missions_text":
			container.get_child(i).queue_free()
	if mission_controller.current_mission != null:
		for t in mission_controller.current_mission.tasks:
			var new_mission = mission_scene.instance()
			new_mission.get_node("text_label").text = t.text
			new_mission.get_node("current_amount_label").text = String(t.current_amount)
			new_mission.get_node("amount_label").text = String(t.amount)
			container.add_child(new_mission)
	
	animation_player.play("mission_notification")
	print_debug("play mission notification")
	pass
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
