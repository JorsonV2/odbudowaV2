extends Area2D

export var dialouge_name = ""

var active = true
var proper_dialouge
var dialouge_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$dialouge_container.hide()
	if dialouge_name == "":
		disable_trigger()
	else:
		proper_dialouge = dialouge_controller.dialouges[dialouge_name]
	pass
	
func update_trigger_state():
	
	if dialouge_name == "":
		disable_trigger()
		pass
	else:
		var mission_task
		var disable = true
		if mission_controller.current_mission != null: 
			mission_task = mission_controller.current_mission.tasks[0]
			if mission_task.type == "talk":
				if mission_task.object == dialouge_controller.dialouges[dialouge_name].object:
					proper_dialouge = dialouge_controller.dialouges[dialouge_name]
					disable = false
		if disable:
			disable_trigger()
	pass

func enable_trigger():
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	pass

func disable_trigger():
	active = false
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	pass

func start_dialouge():
	game_controller.in_game_ui.hide_missions()
	$dialouge_container.show()
	show_dialouge()
	game_controller.game_stop = true
	pass
	
func end_dialouge():
	game_controller.in_game_ui.show_missions()
	disable_trigger()
	$dialouge_container.hide()
	game_controller.game_stop = false
	signals.emit_mission_task("talk", proper_dialouge.object)
	print_debug(proper_dialouge.object)
	pass
	
func show_dialouge():
	find_node("dialouge_label").text = proper_dialouge.statements[dialouge_count]
	pass

func next_statement():
	dialouge_count += 1
	if dialouge_count < proper_dialouge.statements.size():
		show_dialouge()
	else:
		end_dialouge()
		pass
	pass

func _on_trigger_dialouge_area_entered(area):
	if area.is_in_group("player") and active:
		if proper_dialouge != null:
			proper_dialouge = dialouge_controller.dialouges[dialouge_name]
		if mission_controller.current_mission != null:
			if mission_controller.current_mission.tasks[0].type == "talk":
				if mission_controller.current_mission.tasks[0].object == proper_dialouge.object:
					start_dialouge()
	pass # Replace with function body.

func _on_next_button_pressed():
	next_statement()
	pass # Replace with function body.
