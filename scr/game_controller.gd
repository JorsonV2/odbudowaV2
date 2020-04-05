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
var fade_animation_scene
var fade_animation : fade_animation
var activated_buildings = []
var meteor_video_scene
var game_stop = false


# Called when the node enters the scene tree for the first time.
func _ready():
	signals.connect("update_equipment", self, "update_equipment")
	signals.connect("mission_trigger", self, "mission_trigger")
	player_scene = preload("res://scenes/player_scene.tscn")
	in_game_ui = preload("res://scenes/in_game_ui.tscn")
	village_scene = preload("res://scenes/village_scene.tscn")
	forest_scene = preload("res://scenes/forest1_scene.tscn")
	deep_forest_scene = preload("res://scenes/deep_forest_scene.tscn")
	fade_animation_scene = preload("res://scenes/fade_animation_scene.tscn")
	meteor_video_scene = preload("res://scenes/meteor_video_scene.tscn")
	random.randomize()
	pass # Replace with function body.

func update_equipment(equipment):
	player_equipment = equipment
	pass
	
func mission_trigger(trigger):
	if trigger == "meteor":
		var meteor_video : CanvasLayer = meteor_video_scene.instance()
		fade_animation.show()
		fade_animation.play_fade()
		game_stop = true
		yield(fade_animation.animation_player, "animation_finished")
		get_tree().get_root().add_child(meteor_video)
		fade_animation.play_backwards_fade()
		yield(meteor_video.get_node("VideoPlayer"), "finished")
		meteor_video.queue_free()
		fade_animation.play_backwards_fade()
		yield(fade_animation.animation_player, "animation_finished")
		fade_animation.hide()
		game_stop = false
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
