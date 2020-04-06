extends building

func _ready():
	find_node("regenerate_button").connect("pressed", self, "regeneration")
	pass

func action():
	game_controller.fade_animation.show()
	game_controller.fade_animation.play_fade()
	yield(game_controller.fade_animation.animation_player, "animation_finisfed")
	game_controller.player.health = game_controller.player.health
	pass
	
func regeneration():
	game_controller.fade_animation.show()
	game_controller.game_stop = true
	game_controller.fade_animation.play_fade()
	yield(game_controller.fade_animation.animation_player, "animation_finished")
	game_controller.player.health = game_controller.player.max_health
	signals.emit_update_health(game_controller.player.health)
	game_controller.fade_animation.play_backwards_fade()
	yield(game_controller.fade_animation.animation_player, "animation_finished")
	game_controller.fade_animation.hide()
	game_controller.game_stop = false
	pass
