extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	if file.file_exists("user://villagereborn.save"):
		find_node("load_button").disabled = false
		pass
	yield(get_tree().create_timer(2), "timeout")
	game_controller.fade_animation.show()
	game_controller.fade_animation.play_fade()
	yield(game_controller.fade_animation.animation_player, "animation_finished")
	find_node("logo").hide()
	game_controller.fade_animation.play_backwards_fade()
	yield(game_controller.fade_animation.animation_player, "animation_finished")
	game_controller.fade_animation.hide()
	
	pass # Replace with function body.

func _on_load_button_pressed():
	save_game.load_the_game()
	pass # Replace with function body.

func _on_start_button_pressed():
	game_controller.start_the_game()
	pass # Replace with function body.
