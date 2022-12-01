extends Node
var direction
var position
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var deaths = 0

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

func shield_hit():
	var Shield = get_node_or_null("/root/Game/Dragon")
	Shield.shield_hit()

func damage():
	var Dragon = get_node_or_null("/root/Game/Dragon")
	Dragon.damage()
	
func summon_fireball():
	var Fireball = get_node_or_null("/root/Game/Fireball_Container")
	Fireball.summon_fireball()
