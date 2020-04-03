extends being_controller

class_name enemy

signal exit_spawn_point

export var distance_enemy = false
export var field_of_view = 200
export var damage = 10
export var equipment_amount = [0,0,0,0]
export var hit_stand_time = 0.3

var flipped_left = false
var patrol_position = Vector2()
var player
var is_patroling = true
var patrol_distance = 100
var patrol_stand_time = 3
var patrol_direction = 1
var patrol_stop = false
var time_delta
var current_hit_stand_time = 0
var current_animation = "stand"
var hitting = false

func _ready():
	print_debug("elo jestem mobem")
	$Area2D.add_to_group("enemy")
	$animated_sprite.connect("animation_finished", self, "animation_finished")
	#$Area2D.connect("area_entered", self, "area_entered")
	patrol_position = global_position
	player = game_controller.player
	for ea in range(0, equipment_amount.size()):
		equipment[ea] = game_controller.random.randi_range(0, equipment_amount[ea])
	pass

func _process(delta):
	
	movement.x = 0
	
#	if current_hit_stand_time > 0:
#		current_hit_stand_time -= delta
#	else:
#		active_move = true
	check_if_player_overlaps()
	time_delta = delta
	if active_move:
		action()
		if not is_patroling:
			movement.x = movement_speed * direction
			
	if movement.x != 0:
		current_animation = "run"
	else:
		current_animation = "stand"

	if !active_move and hitting:
		current_animation = "hit"
	
	if movement.x < 0 and !flipped_left:
		flip_enemy()
	elif movement.x > 0 and flipped_left:
		flip_enemy()
	if $animated_sprite.animation != current_animation:
		#print_debug(current_animation)
		$animated_sprite.play(current_animation)
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
			patrol_stand_time = randi() % 5 + 1
	pass
	
func flip_enemy():
	flipped_left = !flipped_left
	$animated_sprite.flip_h = flipped_left
	pass
	
func dead():
	emit_signal("exit_spawn_point")
	.dead()
	pass
	
func hit_player():
	if !player.immute:
		active_move = false
		hitting = true
		player.take_damage(2)
	pass
	
func stop_hitting_player():
	if current_animation != "hit":
		active_move = true
		hitting = false
	pass	
	
func check_if_player_overlaps():
	if $Area2D.overlaps_area(player.get_node("Area2D")):
		active_move = false
		hit_player()
	pass
	
func animation_finished():
	if $animated_sprite.animation == "hit":
		active_move = true
		hitting = false
	pass
