extends Node

var dialouges = {}
var dialouge_directory = "res://dialouges"

func _ready():
	create_dialouges()
	pass
	
func create_dialouges():
	var dialouge_files = get_dialouge_files()
	for file_name in dialouge_files:
		create_dialouge_from_file(file_name)
		pass
	pass
	
func create_dialouge_from_file(file_name : String):
	var file = File.new()
	file.open(dialouge_directory + "/" + file_name, File.READ)
	var dialouge_text = file.get_as_text()
	var dialouge_splitted = dialouge_text.split("-")
	var new_dialouge : dialouge
	for d in dialouge_splitted:
		if d.split(":")[0] == "trigger":
			new_dialouge = dialouge.new(d.split(":")[1], d.split(":")[2])
		else:
			new_dialouge.add_statement(d)
	dialouges[file_name.split(".")[0]] = new_dialouge
	pass

func get_dialouge_files():
	var files = []
	var dir = Directory.new()
	dir.open(dialouge_directory)
	dir.list_dir_begin()
	while true:
		var file : String = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
	dir.list_dir_end()
	return files
	pass

