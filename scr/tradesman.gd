extends Area2D

export var cost_for_gold = [0,0,0]
export var cost_for_wood = [0,0,0]
export var cost_for_rock = [0,0,0]
export var cost_for_leather = [0,0,0]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_tradesman_area_entered(area):
	find_node("trade_info").show()
	pass # Replace with function body.


func _on_tradesman_area_exited(area):
	find_node("trade_info").hide()
	pass # Replace with function body.
