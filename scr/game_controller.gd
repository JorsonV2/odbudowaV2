extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time 
var day = true
var random = RandomNumberGenerator.new()
var player_equipment = [0,0,0,0]
var player_dead = false
var game_stop = false
var player_destination
var activated_buildings = []
var meteor_fallen = false
var blacksmith_rescued = false
var guard_rescued = false

var player_scene
var camera_scene
var village_scene
var forest_scene
var deep_forest_scene
var forest_right_scene
var deep_forest_right_scene
var savage_village_scene
var lobby_scene

var fade_animation_scene
var meteor_video_scene
var in_game_ui_scene

var in_game_ui
var player : player
var fade_animation : fade_animation

# Called when the node enters the scene tree for the first time.
func _ready():
	signals.connect("update_equipment", self, "update_equipment")
	signals.connect("mission_trigger", self, "mission_trigger")
	player_scene = preload("res://scenes/player_scene.tscn")
	camera_scene = preload("res://scenes/camera_scene.tscn")
	in_game_ui_scene = preload("res://scenes/in_game_ui.tscn")
	village_scene = preload("res://scenes/village_scene.tscn")
	forest_scene = preload("res://scenes/forest1_scene.tscn")
	deep_forest_scene = preload("res://scenes/deep_forest_scene.tscn")
	forest_right_scene = preload("res://scenes/forest2_scene.tscn")
	deep_forest_right_scene = preload("res://scenes/forest3_scene.tscn")
	savage_village_scene = preload("res://scenes/savage_village_scene.tscn")
	fade_animation_scene = preload("res://scenes/fade_animation_scene.tscn")
	meteor_video_scene = preload("res://scenes/meteor_video_scene.tscn")
	lobby_scene = preload("res://scenes/lobby_scene.tscn")
	
	var fade_animation_instance = fade_animation_scene.instance()
	fade_animation = fade_animation_instance
	get_tree().get_root().call_deferred("add_child", fade_animation)
	
	random.randomize()
	pass # Replace with function body.

func update_equipment(equipment):
	player_equipment = equipment
	pass
	
func mission_trigger(trigger):
	if trigger == "meteor":
		play_meteor_video()
	if trigger == "find_smith":
		blacksmith_rescued = true
	if trigger == "find_guard":
		guard_rescued = true
	pass
	
func play_meteor_video():
	meteor_fallen = true
	var meteor_video : CanvasLayer = meteor_video_scene.instance()
	fade_animation.show()
	fade_animation.play_fade()
	game_stop = true
	yield(fade_animation.animation_player, "animation_finished")
	get_tree().get_root().add_child(meteor_video)
	fade_animation.play_backwards_fade()
	yield(meteor_video.get_node("VideoPlayer"), "finished")
	fade_animation.play_backwards_fade()
	yield(get_tree().create_timer(0.2), "timeout")
	meteor_video.queue_free()
	yield(fade_animation.animation_player, "animation_finished")
	fade_animation.hide()
	game_stop = false
	signals.emit_mission_complete()
	pass
	
func start_the_game():
	save_game.delete_save()
	if get_tree().get_root().has_node("lobby"):
		get_tree().get_root().get_node("lobby").queue_free()
	get_tree().get_root().call_deferred("add_child", village_scene.instance())
	
	yield(signals, "add_map")
	
	game_controller.player.position = get_tree().get_root().get_node("map/start_position").position
	get_tree().get_root().get_node("map/start_trigger").start_dialouge()
	
	pass
	
func go_to_lobby():
	restart_game_controller()
	var lobby = lobby_scene.instance()
	fade_animation.show()
	fade_animation.play_fade()
	get_tree().get_root().get_node("map").hide()
	in_game_ui.queue_free()
	yield(fade_animation.animation_player, "animation_finished")
	fade_animation.play_backwards_fade()
	get_tree().get_root().call_deferred("add_child", lobby)
	yield(fade_animation.animation_player, "animation_finished")
	fade_animation.hide()
	get_tree().get_root().get_node("map").queue_free()
	pass
	
func restart_game_controller():
	player_equipment = [0,0,0,0]
	activated_buildings = []
	meteor_fallen = false
	blacksmith_rescued = false
	guard_rescued = false
	player_dead = false
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
