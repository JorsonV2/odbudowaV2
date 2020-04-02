extends Area2D

class_name building

export (Texture) var ruins_texture
export (Texture) var building_texture
export var resources_to_build = [0,0,0,0]
export var resources_to_action = [0,0,0,0]
export var building_name = "Building name"
export var build_text = "Build text"
export var action_text = "Action text"

var active = false

func _ready():
	connect("area_entered", self, "building_entered")
	connect("area_exited", self, "building_exited")
	find_node("build_button").connect("pressed", self, "build")
	update_build_requirements()
	update_action_requirements()
	update_texts()
	pass

func player_entered():
	show_bulding_info()
	find_node("Sprite").modulate = Color(0.3,0.3,0.3)
	if active:
		show_action_info()
		pass
	else:
		show_build_info()
		pass
	pass
	
func player_exited():
	hide_building_info()
	find_node("Sprite").modulate = Color(1,1,1)
	if active:
		hide_action_info()
		pass
	else:
		hide_build_info()
		pass
	pass

func show_build_info():
	find_node("build_info").show()
	pass
	
func hide_build_info():
	find_node("build_info").hide()
	pass

func show_action_info():
	find_node("action_info").show()
	pass
	
func hide_action_info():
	find_node("action_info").hide()
	pass
	
func show_bulding_info():
	find_node("building_info").show()
	pass
	
func hide_building_info():
	find_node("building_info").hide()
	pass
	
func building_entered(area):
	if area.is_in_group("player"):
		player_entered()
	pass
	
func building_exited(area):
	if area.is_in_group("player"):
		player_exited()
	pass

func action():
	pass
	
func build():
	find_node("Sprite").texture = building_texture
	hide_build_info()
	show_action_info()
	active = true
	signals.emit_mission_task("build", building_name)
	pass
	
func update_build_requirements():
	var build_info = find_node("build_info")
	for e in range(resources_to_build.size()):
		var resource_name
		match e:
			0:
				resource_name = "gold"
			1:
				resource_name = "wood"
			2:
				resource_name = "rock"
			3:
				resource_name = "leather"
		build_info.find_node(resource_name+"_amount").text = String(resources_to_build[e])
	pass
	
func update_action_requirements():
	var action_info = find_node("action_info")
	for e in range(resources_to_action.size()):
		var resource_name
		match e:
			0:
				resource_name = "gold"
			1:
				resource_name = "wood"
			2:
				resource_name = "rock"
			3:
				resource_name = "leather"
		action_info.find_node(resource_name+"_amount").text = String(resources_to_action[e])
	pass		
	
func update_texts():
	find_node("building_name").text = building_name
	find_node("build_label").text = build_text
	find_node("action_label").text = action_text
	pass

