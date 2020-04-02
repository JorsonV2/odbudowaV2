extends being_controller

class_name player

export (PackedScene) var arrow_scene

var double_jump = false
var sword_active = false
var active_weapon = "bow"
var first_weapon_damage = 10
var secound_weapon_damage = 10
var flipped_left = false
var max_health = 100

func _ready():
	signals.connect("collect_item", self, "collected_item")
	signals.emit_update_health(health)
	pass

func _process(delta):
	movement.x = 0
	if active_move:
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
				$aniamated_sprite.play("stand")
			else:
				$aniamated_sprite.play("run")
		else:
			if movement.y > 0:
				$aniamated_sprite.play("fall")
			else:
				$aniamated_sprite.play("jump")
			
		
		
	pass
	
func shoot_arrow():
	var arrow = arrow_scene.instance()
	arrow.position = $shoot_position.global_position
	arrow.linear_velocity = Vector2(600 * direction, 3)
	arrow.damage = first_weapon_damage
	get_tree().get_root().add_child(arrow)
	
	pass
	
func hit_with_sword():
	pass
	
func flip_player():
	flipped_left = !flipped_left
	$aniamated_sprite.flip_h = !$aniamated_sprite.flip_h
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
	signals.emit_update_health(health)
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("item"):
		#add item to equipment
		body.collected()
	pass # Replace with function body.

func _on_Area2D_area_entered(area):
	if area.is_in_group("enemy"):
		print_debug(area, "enemy_atack")
		area.get_parent().hit_player()
		
	pass # Replace with function body.
