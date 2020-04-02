extends Position2D

export var spawn_distance = 300
export (PackedScene) var enemy_scene
export var max_spawn_count = 4

var current_spawn_count = 0
var spawn_time = 3
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("testMap/player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawn_time > 0:
		spawn_time -= delta
	else:
		spawn_time = 3
		if player != null:
			if global_position.distance_to(player.global_position) - (get_viewport().size.x / 2) - (spawn_distance * 2) > 0:
				#jeżeli brakuje mobów to je spawni
				if current_spawn_count < max_spawn_count:
					spawn_enemy()
					pass
				pass
	pass
	
func spawn_enemy():
	print_debug("spawn enemy")
	var new_enemy = enemy_scene.instance()
	new_enemy.position.x = randi() % (2 * spawn_distance) - spawn_distance
	add_child(new_enemy)
	new_enemy.connect("exit_spawn_point", self, "enemy_exited_spawn_point")
	current_spawn_count += 1
	pass
	
func enemy_exited_spawn_point():
	current_spawn_count -= 1
	pass
