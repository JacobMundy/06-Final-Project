extends Node
var direction
var position
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_direction():
	var Player = get_node_or_null("/root/Game/Player_Container/Player")
	direction = Player.direction
	return direction
	
func get_position():
	var Player = get_node_or_null("/root/Game/Player_Container/Player/Sprite")
	position = Player.global_position
	return position
