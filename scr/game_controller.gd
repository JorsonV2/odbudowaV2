extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time 
var day = true
var random = RandomNumberGenerator.new()
var player_equipment = [0,0,0,0]
var player_scene
var in_game_ui
var player : player
var player_destination
var village_scene
var forest_scene
var deep_forest_scene
var scene_changer_scene
var scene_changer
var activated_buildings = []


# Called when the node enters the scene tree for the first time.
func _ready():
	signals.connect("update_equipment", self, "update_equipment")
	player_scene = preload("res://scenes/player_scene.tscn")
	in_game_ui = preload("res://scenes/in_game_ui.tscn")
	village_scene = preload("res://scenes/village_scene.tscn")
	forest_scene = preload("res://scenes/forest_scene.tscn")
	deep_forest_scene = preload("res://scenes/deep_forest_scene.tscn")
	scene_changer_scene = preload("res://scenes/Scene_animation.tscn")
	random.randomize()
	pass # Replace with function body.

func update_equipment(equipment):
	player_equipment = equipment
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
