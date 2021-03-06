extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (PackedScene) var mission_scene

var animation_player
var mission_notification 

# Called when the node enters the scene tree for the first time.
func _ready():
	#signals.connect("update_equipment", self, "update_equipment")
	signals.connect("update_health", self, "update_health")
	signals.connect("update_current_mission", self, "update_current_mission")
	signals.connect("mission_completed", self, "mission_completed")
	signals.connect("dead", self, "player_dead")
	signals.connect("win", self, "win")
	animation_player = $animation_player
	mission_notification = find_node("mission_notification")
#	$right_container.mouse_filter = 1
#	for control in $right_container.get_children():
#		control.mouse_filter = 1
#		pass
	update_current_mission()
	pass # Replace with function body.
	
func update_equipment():
	var equipment = game_controller.player.equipment
	find_node("gold_amound").text = String(equipment[0])
	find_node("wood_amound").text = String(equipment[1])
	find_node("rock_amound").text = String(equipment[2])
	find_node("leather_amound").text = String(equipment[3])
#	for e in range(0, equipment.size()):
#		match e:
#			0:
#				find_node("gold_amound").text = String(equipment[e])
#			1:
#				find_node("wood_amound").text = String(equipment[e])
#			2:
#				find_node("rock_amound").text = String(equipment[e])
#			3:
#				find_node("leather_amound").text = String(equipment[e])
	#print_debug("ui ", equipment)
func update_health():
	if game_controller.player != null:
		find_node("health_bar").value = game_controller.player.health
		find_node("health_bar").max_value = game_controller.player.max_health
	
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
	pass
	
func mission_completed():
	$sfx_complete.play()
	play_mission_notification()
	pass
	
func play_mission_notification():
	mission_notification.show()
	animation_player.play("mission_notification")
	yield(animation_player, "animation_finished")
	mission_notification.hide()
	pass
	
func hide_missions():
	find_node("missions_box").hide()
	pass

func show_missions():
	find_node("missions_box").show()
	pass

func player_dead():
	$save_button.disabled = true
	yield(get_tree().create_timer(1.0), "timeout")
	$dead_panel.show()
	
	pass

func win():
	find_node("win_panel").show()
	pass

func _on_Button_pressed():
	save_game.save_the_game()
	pass # Replace with function body.

func _on_dead_button_pressed():
	game_controller.go_to_lobby()
	pass # Replace with function body.

func _on_win_button_pressed():
	find_node("win_panel").hide()
	pass # Replace with function body.
