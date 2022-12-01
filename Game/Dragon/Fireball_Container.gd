extends Node2D

onready var Fireball= load("res://Dragon/Fireball.tscn")


func summon_fireball():
	var fireball = Fireball.instance()
	add_child(fireball)
	var Dragon = get_node_or_null("/root/Game/Dragon")
	fireball.position = Dragon.position
	fireball.name = 'Fireball'

func die():
	var children = get_children()
	for n in children:
		n.die()
