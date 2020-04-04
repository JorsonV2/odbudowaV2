extends being_controller

class_name enemy

signal exit_spawn_point

export var is_hitting = true
export var field_of_view = 200
export var damage = 10
export var equipment_amount = [0,0,0,0]
export var hit_stand_time = 0.3
export var dangerous = true
export var save_distance = 200

var flipped_left = false
var patrol_position = Vector2()
var player
var is_patroling = true
var patrol_distance = 100
var patrol_stand_time = 3
var patrol_stop = false
var time_delta
var current_hit_stand_time = 0
var current_animation = "stand"
var hitting = false
var running_away = false
var jumped = false
var previous_jump_position_y
var moving_away_from_player = false


func _ready():
	$Area2D.add_to_group("enemy")
	$animated_sprite.connect("animation_finished", self, "animation_finished")
	patrol_position = global_position
	player = game_controller.player
	for ea in range(0, equipment_amount.size()):
		equipment[ea] = game_controller.random.randi_range(0, equipment_amount[ea])
	pass

func _process(delta):
	
#	if current_hit_stand_time > 0:
#		current_hit_stand_time -= delta
#	else:
#		active_move = true
	check_if_player_overlaps()
	time_delta = delta
	if active_move:
		move()

		if is_patroling:
			movement.x = movement_speed * 0.5 * direction
		else:
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
	
func move():
	
	if is_on_floor():
		if jumped and previous_jump_position_y == global_position.y:
			direction = -direction
			jumped = false
		elif !patrol_stop and movement.x == 0:
			previous_jump_position_y = global_position.y
			movement.y = -jump_force
			jumped = true
			
	if global_position.distance_to(player.global_position) < field_of_view:
		var direction_to_player = global_position.direction_to(player.global_position)
		if is_patroling:
			is_patroling = false
		if dangerous:
			move_to_player(direction_to_player)
		else:
			move_away_from_player(direction_to_player)
	elif running_away:
		var direction_to_player = global_position.direction_to(player.global_position)
		move_away_from_player(direction_to_player)
	else:
		if is_patroling:
			patrol()
		else:
			is_patroling = true
			patrol_position = global_position
			
	pass
	
func move_to_player(direction_to_player):
	if direction_to_player.x > 0:
		direction = 1
	else:
		direction = -1
	pass
	
func move_away_from_player(player_direction):
	move_to_player(player_direction)
	direction = -direction
	if global_position.distance_to(game_controller.player.global_position) < field_of_view + save_distance:
		running_away = true
	else:
		running_away = false
	pass
	
func patrol():
	if patrol_stand_time > 0:
		direction = 0
		if !patrol_stop:
			patrol_stop = true
			patrol_position.x += direction * 10
		patrol_stand_time -= time_delta
	else:
#		if is_on_floor() and jumped:
#			if previous_jump_position_y == global_position.y:
#				direction = -direction
#				jumped = false
		if patrol_stop:
			patrol_stop = false
			if patrol_position.x - global_position.x > 0:
				direction = 1
			else:
				direction = -1
		if -(patrol_position.x - global_position.x) * direction > patrol_distance:
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
	if !player.immute and dangerous:
		active_move = false
		hitting = true
		player.take_damage(2)
	pass
	
func stop_hitting_player():
	if current_animation != "hit" and is_hitting:
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
