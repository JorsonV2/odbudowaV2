extends Node2D

var left_spawn_point
var right_spawn_point

# Called when the node enters the scene tree for the first time.
func _ready():
	signals.connect("spawn_player", self, "spawn_player")
	left_spawn_point = get_node("left_spawn_point")
	right_spawn_point = get_node("right_spawn_point")
	if game_controller.player == null:
		spawn_player()
	else:
		if game_controller.player_destination == "left":
			game_controller.player.position = left_spawn_point.position
		else:
			game_controller.player.position = right_spawn_point.position
	pass # Replace with function body.
	
func spawn_player():
	var fade_animation = game_controller.fade_animation_scene.instance()
	var player = game_controller.player_scene.instance()
	var in_game_ui = game_controller.in_game_ui.instance()
	player.position = left_spawn_point.position
	game_controller.player = player
	game_controller.fade_animation = fade_animation
	get_tree().get_root().call_deferred("add_child", in_game_ui)
	get_tree().get_root().call_deferred("add_child", player)
	get_tree().get_root().call_deferred("add_child", fade_animation)
	pass
	
func hide():
	.hide()
	get_node("background").free()
	pass


