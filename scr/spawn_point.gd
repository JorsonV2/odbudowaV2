tool

extends Position2D

export var spawn_distance = 300
export (PackedScene) var enemy_scene
export var max_spawn_count = 4
export var spawn_time = 2

var current_spawn_count = 0
var current_spawn_time = spawn_time
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = game_controller.player
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Engine.editor_hint:
		if current_spawn_time > 0:
			current_spawn_time -= delta
		else:
			current_spawn_time = spawn_time
			if player == null:
				player = game_controller.player
			else:
				if global_position.distance_to(player.global_position) - (get_viewport().size.x / 2) - (spawn_distance) > 0:
					#jeżeli brakuje mobów to je spawni
					if current_spawn_count < max_spawn_count:
						spawn_enemy()
						pass
					pass
	
	if Engine.editor_hint:
		set_margin_spawn_posiitons()
	
	pass
	
func spawn_enemy():
	var new_enemy = enemy_scene.instance()
	new_enemy.position.x = randi() % (2 * spawn_distance) - spawn_distance
	add_child(new_enemy)
	new_enemy.connect("exit_spawn_point", self, "enemy_exited_spawn_point")
	current_spawn_count += 1
	pass
	
func enemy_exited_spawn_point():
	current_spawn_count -= 1
	pass
	
func set_margin_spawn_posiitons():
	$left_position.position.x = -spawn_distance
	$right_position.position.x = spawn_distance
	pass
