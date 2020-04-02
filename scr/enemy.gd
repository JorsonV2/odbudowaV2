extends being_controller

class_name enemy

signal exit_spawn_point

export var field_of_view = 200
export var damage = 10
export var equipment_amount = [0,0,0,0]

var flipped_left = false
var patrol_position = Vector2()
var player
var is_patroling = true
var patrol_distance = 100
var patrol_stand_time = 3
var patrol_direction = 1
var patrol_stop = false
var time_delta

func _ready():
	patrol_position = global_position
	player = get_tree().get_root().get_node("testMap/player")
	for ea in range(0, equipment_amount.size()):
		equipment[ea] = game_controller.random.randi_range(0, equipment_amount[ea])
	pass

func _process(delta):
	time_delta = delta
	action()
	if not is_patroling:
		movement.x = movement_speed * direction
	
	if movement.x < 0 and !flipped_left:
		flip_enemy()
	elif movement.x > 0 and flipped_left:
		flip_enemy()
			
	if movement.x != 0:
		$animated_sprite.play("run")
	else:
		$animated_sprite.play("stand")
	pass
	
func action():
	if global_position.distance_to(player.global_position) < field_of_view:
		if is_patroling:
			is_patroling = false
		var vector = global_position.direction_to(player.global_position)
		if vector.x > 0:
			direction = 1
		else:
			direction = -1
	else:
		if is_patroling:
			patrol()
		else:
			is_patroling = true
			direction = 0
			patrol_position = global_position
	pass
	
func patrol():
	if patrol_stand_time > 0:
		movement.x = 0
		if !patrol_stop:
			patrol_stop = true
			patrol_position.x += patrol_direction * 10
		patrol_stand_time -= time_delta
	else:
		if patrol_stop:
			patrol_stop = false
			patrol_direction = -patrol_direction
		movement.x = movement_speed * 0.5 * patrol_direction
		if patrol_position.distance_to(global_position) > patrol_distance :
			randomize()
			patrol_stand_time = randi() % 5 + 1
	pass
	
func flip_enemy():
	flipped_left = !flipped_left
	$animated_sprite.flip_h = flipped_left
	pass
	
func dead():
	.dead()
	emit_signal("exit_spawn_point")
	pass
