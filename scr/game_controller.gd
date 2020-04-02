extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time 
var day = true
var random = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
