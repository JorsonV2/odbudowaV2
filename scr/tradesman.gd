extends Area2D

export var cost_for_gold = [0,0,0]
export var cost_for_wood = [0,0,0]
export var cost_for_rock = [0,0,0]
export var cost_for_leather = [0,0,0]

var gold_panel
var wood_panel
var rock_panel
var leather_panel

# Called when the node enters the scene tree for the first time.
func _ready():
	if game_controller.buildings_builded:
		hide()
		set_deferred("monitorable", false)
		set_deferred("monitoring", false)
	else:
		gold_panel = find_node("gold_panel")
		wood_panel = find_node("wood_panel")
		rock_panel = find_node("rock_panel")
		leather_panel = find_node("leather_panel")
		set_costs()
	pass # Replace with function body.

func update_buttons():
	for c in range(cost_for_gold.size()):
		var disabled = false
		var button
		match c:
			0:
				button = gold_panel.find_node("wood_for_gold_button")
				if cost_for_gold[c] > game_controller.player.equipment[1]:
					disabled = true
			1:
				button = gold_panel.find_node("rock_for_gold_button")
				if cost_for_gold[c] > game_controller.player.equipment[2]:
					disabled = true
			2:
				button = gold_panel.find_node("leather_for_gold_button")
				if cost_for_gold[c] > game_controller.player.equipment[3]:
					disabled = true
		button.disabled = disabled
					
	for c in range(cost_for_wood.size()):
		var disabled = false
		var button
		match c:
			0:
				button = wood_panel.find_node("gold_for_wood_button")
				if cost_for_wood[c] > game_controller.player.equipment[0]:
					disabled = true
			1:
				button = wood_panel.find_node("rock_for_wood_button")
				if cost_for_wood[c] > game_controller.player.equipment[2]:
					disabled = true
			2:
				button = wood_panel.find_node("leather_for_wood_button")
				if cost_for_wood[c] > game_controller.player.equipment[3]:
					disabled = true
		button.disabled = disabled
		
	for c in range(cost_for_rock.size()):
		var disabled = false
		var button
		match c:
			0:
				button = rock_panel.find_node("gold_for_rock_button")
				if cost_for_rock[c] > game_controller.player.equipment[0]:
					disabled = true
			1:
				button = rock_panel.find_node("wood_for_rock_button")
				if cost_for_rock[c] > game_controller.player.equipment[1]:
					disabled = true
			2:
				button = rock_panel.find_node("leather_for_rock_button")
				if cost_for_rock[c] > game_controller.player.equipment[3]:
					disabled = true
		button.disabled = disabled
	
	for c in range(cost_for_leather.size()):
		var disabled = false
		var button
		match c:
			0:
				button = leather_panel.find_node("gold_for_leather_button")
				if cost_for_leather[c] > game_controller.player.equipment[0]:
					disabled = true
			1:
				button = leather_panel.find_node("wood_for_leather_button")
				if cost_for_leather[c] > game_controller.player.equipment[1]:
					disabled = true
			2:
				button = leather_panel.find_node("rock_for_leather_button")
				if cost_for_leather[c] > game_controller.player.equipment[2]:
					disabled = true
		button.disabled = disabled
		
	pass
	
func set_costs():
	for c in range(cost_for_gold.size()):
		var container
		match c:
			0:
				container = gold_panel.find_node("wood_for_gold")
			1:
				container = gold_panel.find_node("rock_for_gold")
			2:
				container = gold_panel.find_node("leather_for_gold")
		container.get_node("amount_label").text = String(cost_for_gold[c])
		
	for c in range(cost_for_wood.size()):
		var container
		match c:
			0:
				container = wood_panel.find_node("gold_for_wood")
			1:
				container = wood_panel.find_node("rock_for_wood")
			2:
				container = wood_panel.find_node("leather_for_wood")
		container.get_node("amount_label").text = String(cost_for_wood[c])
		
	for c in range(cost_for_rock.size()):
		var container
		match c:
			0:
				container = rock_panel.find_node("gold_for_rock")
			1:
				container = rock_panel.find_node("wood_for_rock")
			2:
				container = rock_panel.find_node("leather_for_rock")
		container.get_node("amount_label").text = String(cost_for_rock[c])
		
	for c in range(cost_for_leather.size()):
		var container
		match c:
			0:
				container = leather_panel.find_node("gold_for_leather")
			1:
				container = leather_panel.find_node("wood_for_leather")
			2:
				container = leather_panel.find_node("rock_for_leather")
		container.get_node("amount_label").text = String(cost_for_leather[c])
	pass
	
func add_resoure(resource, val):
	match resource:
		"gold":
			game_controller.player_equipment[0] += val
		"wood":
			game_controller.player_equipment[1] += val
		"rock":
			game_controller.player_equipment[2] += val
		"leather":
			game_controller.player_equipment[3] += val
	
	signals.emit_update_equipment(game_controller.player_equipment)
	update_buttons()
	pass

func _on_tradesman_area_entered(area):
	if area.is_in_group("player"):
		update_buttons()
		find_node("trade_info").show()
		game_controller.in_game_ui.hide_missions()
	pass # Replace with function body.


func _on_tradesman_area_exited(area):
	if area.is_in_group("player"):
		find_node("trade_info").hide()
		game_controller.in_game_ui.show_missions()
	pass # Replace with function body.


func _on_wood_for_gold_button_pressed():
	add_resoure("gold", 1)
	add_resoure("wood", -cost_for_gold[0])
	pass # Replace with function body.


func _on_rock_for_gold_button_pressed():
	add_resoure("gold", 1)
	add_resoure("rock", -cost_for_gold[1])
	pass # Replace with function body.


func _on_leather_for_gold_button_pressed():
	add_resoure("gold", 1)
	add_resoure("leather", -cost_for_gold[2])
	pass # Replace with function body.


func _on_gold_for_wood_button_pressed():
	add_resoure("wood", 1)
	add_resoure("gold", -cost_for_wood[0])
	pass # Replace with function body.


func _on_rock_for_wood_button_pressed():
	add_resoure("wood", 1)
	add_resoure("rock", -cost_for_wood[1])
	pass # Replace with function body.


func _on_leather_for_wood_button_pressed():
	add_resoure("wood", 1)
	add_resoure("leather", -cost_for_wood[2])
	pass # Replace with function body.


func _on_gold_for_rock_button_pressed():
	add_resoure("rock", 1)
	add_resoure("gold", -cost_for_rock[0])
	pass # Replace with function body.


func _on_wood_for_rock_button_pressed():
	add_resoure("rock", 1)
	add_resoure("wood", -cost_for_rock[1])
	pass # Replace with function body.


func _on_leather_for_rock_button_pressed():
	add_resoure("rock", 1)
	add_resoure("leather", -cost_for_rock[2])
	pass # Replace with function body.


func _on_gold_for_leather_button_pressed():
	add_resoure("leather", 1)
	add_resoure("gold", -cost_for_leather[0])
	pass # Replace with function body.


func _on_wood_for_leather_button_pressed():
	add_resoure("leather", 1)
	add_resoure("wood", -cost_for_leather[1])
	pass # Replace with function body.


func _on_rock_for_leather_button_pressed():
	add_resoure("leather", 1)
	add_resoure("rock", -cost_for_leather[2])
	pass # Replace with function body.


func _on_wood_for_rock_button_mouse_entered():
	print_debug("elo melonajechałeś mnie")
	pass # Replace with function body.
