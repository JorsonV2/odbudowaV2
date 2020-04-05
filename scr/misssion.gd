extends Node

class_name mission

class task:
	var text
	var type
	var object
	var amount
	var current_amount
	var completed
	
	func _init(task_text : String, task_type : String, task_object : String, task_amount : int):
		text = task_text
		type = task_type
		object = task_object
		amount = task_amount
		current_amount = 0
		completed = false

var active = false 
var completed = false
var next_mission : mission
var tasks = []
var trigger

func _init(mission_trigger = null):
	trigger = mission_trigger
	pass

func add_task(text, type, object, amount):
	tasks.append(task.new(text, type, object, amount))
	#signals.connect(type + "_" + object, self, )
	pass
	
func mission_task(task_type, task_object):
	for t in tasks:
		if t.type == task_type and t.object == task_object:
			if t.current_amount < t.amount:
				t.current_amount += 1
				signals.emit_update_current_mission()
				if t.current_amount == t.amount:
					t.completed = true
					check_complition()
					pass
	pass

func check_complition():
	var is_completed = true
	for t in tasks:
		if !t.completed:
			is_completed = false
			break
	completed = is_completed
	if completed:
		complete_mission()
	pass

func complete_mission():
	
	if trigger != null:
		signals.emit_mission_trigger(trigger)
	signals.emit_mission_complete()
	pass
	
func activate_next_mission():
	pass

