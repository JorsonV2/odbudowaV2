extends being_controller

class_name player

export (PackedScene) var arrow_scene
export var immute_time = 2

var double_jump = false
var sword_active = false
var active_weapon = "bow"
var first_weapon_damage = 10
var secound_weapon_damage = 10
var flipped_left = false
var max_health = 100
var current_animation = "stand"
var shooting = false
var current_immute_time = 0
var immute = false

var sound=false

func _ready():
	print_debug("elo melo")
	signals.connect("update_equipment", self, "update_equipment")
	signals.connect("collect_item", self, "collected_item")
	get_node("animated_sprite").connect("animation_finished", self, "animation_finished")
	signals.emit_update_health(health)
	pass

func _process(delta):
	movement.x = 0
	
	if active_move and !game_controller.game_stop:
		
		if Input.is_action_pressed("left"):
			if !flipped_left:
				flip_player()
				direction = -1
			movement.x = -movement_speed
			
		elif Input.is_action_pressed("right"):
			if flipped_left:
				flip_player()
				direction = 1
			movement.x = movement_speed
			
		if Input.is_action_just_pressed("jump"):
			if is_on_floor():
				movement.y = -jump_force
			elif double_jump:
				movement.y = -jump_force
				double_jump = false
			
		if Input.is_action_just_pressed("shoot"):
			if active_weapon == "bow":
				shoot_arrow()
			
		if is_on_floor():
			double_jump = true
			if movement.x == 0:
				current_animation = "stand"
			else:
				current_animation = "run"
		else:
			if movement.y > 0:
				current_animation = "fall"
			else:
				current_animation = "jump"
	elif shooting:
		current_animation = "shot"
		shooting = false
		
	if $animated_sprite.animation != current_animation:
		
		if current_animation == "run":
			sound_off()
			$sfx_run.play()
		elif current_animation == "shot":
			sound_off()
			$sfx_shot.play()
		elif current_animation == "jump":
			sound_off()
			$sfx_jump.play()
		else:
			sound_off()
			
		$animated_sprite.play(current_animation)
	
	
	if current_immute_time > 0:
		current_immute_time -= delta
	elif immute:
		immute = false	
	pass

func sound_off():
	
	$sfx_run.stop()
	$sfx_shot.stop()
	$sfx_jump.stop()
	

func shoot_arrow():
	active_move = false
	shooting = true
	var arrow = arrow_scene.instance()
	arrow.position = $shoot_position.global_position
	arrow.linear_velocity = Vector2(600 * direction, 3)
	arrow.damage = first_weapon_damage
	get_tree().get_root().get_node("map").add_child(arrow)
	
	pass
	
func hit_with_sword():
	pass
	
func flip_player():
	flipped_left = !flipped_left
	$animated_sprite.flip_h = !$animated_sprite.flip_h
	$shoot_position.position.x = -$shoot_position.position.x
	pass

func collected_item(item):
	match item:
		"gold":
			equipment[0] += 1
		"wood":
			equipment[1] += 1
		"rock":
			equipment[2] += 1
		"leather":
			equipment[3] += 1
	#print_debug("player ", equipment)
	signals.emit_update_equipment(equipment)
	pass
	
func take_damage(val):
	.take_damage(val)
	print_debug("take_damage")
	
	$sfx_dmg.play()
	immute = true
	
	current_immute_time = immute_time
	signals.emit_update_health(health)
	pass
	
func dead():
	game_controller.player = null
	$Camera2D.current = false
	var new_camera = game_controller.camera_scene.instance()
	new_camera.current = true
	new_camera.position = position
	get_tree().get_root().add_child(new_camera)
	.dead()
	pass	
	
func animation_finished():
	if current_animation == "shot":
		active_move = true
		current_animation = "stand"
		
	if current_animation == "jump":
		current_animation = "stand"
		
	if current_animation == "run":
		current_animation = "stand"
	
	pass
	
func update_equipment(eq):
	equipment = eq
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("item"):
		#add item to equipment
		body.collected()
	pass # Replace with function body.

func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy") and !game_controller.game_stop:
		area.get_parent().hit_player()
	pass # Replace with function body.

func _on_Area2D_area_exited(area):
	if area.is_in_group("enemy"):
		area.get_parent().stop_hitting_player()
	pass # Replace with function body.
