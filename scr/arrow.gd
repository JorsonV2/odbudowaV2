extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hit_body = false
var follow_body
var offset = Vector2()
var damage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !hit_body:
		rotation = linear_velocity.angle()
	if follow_body != null:
		global_position = follow_body.global_position + offset
	pass
	
func set_body_static():
	hit_body = true
	call_deferred("set_mode", 1)
	set_collision_layer(0)
	set_collision_mask(0)
	pass

func _on_arrow_body_entered(body):
	if body.is_in_group("tilemap"):
		set_body_static()
		queue_free()
	if body.is_in_group("enemy"):
		set_body_static()
		#follow_body = body
		#offset = global_position - body.global_position
		body.take_damage(damage)
		queue_free()
	pass # Replace with function body.
