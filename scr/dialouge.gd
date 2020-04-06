extends Object

class_name dialouge

var trigger
var object
var has_been_triggered = false

var statements = []

func _init(dialouge_trigger, dialouge_object):
	trigger = dialouge_trigger
	object = dialouge_object
	pass
	
func add_statement(text : String):
	statements.append(text)
	pass
	
func get_statement(index):
	has_been_triggered = true
	return statements[index]
	pass
