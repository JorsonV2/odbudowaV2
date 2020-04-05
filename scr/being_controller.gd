extends KinematicBody2D

class_name being_controller

export var health = 100
export var movement_speed = 200

var gravity = 600
var jump_force = 300
var equipment = [0,0,0,0] #gold/wood/rock/leather
var item_scene
var active_move = true
var movement = Vector2()
var is_dead = false

var direction = 1

func _ready():
	item_scene = preload("res://scenes/item_scene.tscn")
	pass

func _process(delta):
	movement.y += gravity * delta
	if active_move:
		movement = move_and_slide(movement, Vector2(0,-1), true)
	else:
		movement = move_and_slide(Vector2(0, movement.y), Vector2(0,-1), true)
	pass
	
func fire_item(name):
	var new_item = item_scene.instance()
	new_item.item_name = name
	new_item.global_position = global_position
	new_item.linear_velocity = Vector2(randi() % 150 - 75, -(randi() % 50 + 50) )
	new_item.angular_velocity = randi() % 40 - 20
	get_tree().get_root().get_node("map").call_deferred("add_child", new_item)
	pass
	
func take_damage(val):
	
	health -= val
	if health <= 0:
		dead()
	
	else:
		if has_node("sfx_dmg"):
		 $sfx_dmg.play(); 
	pass
	
func dead():
	for e in range(equipment.size()):
		for i in range(equipment[e]):
			var item_name
			match e:
				0:
					item_name = "gold"
				1:
					item_name = "wood"
				2:
					item_name = "rock"
				3:
					item_name = "leather"
			fire_item(item_name)
	if has_node("sfx_dead"):
		 $sfx_dead.play(); 
	hide()
	is_dead = true
	set_deferred("collision_layer", 0)
	yield($sfx_dead,"finished")
	queue_free()
	pass
