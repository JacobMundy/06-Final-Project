extends Node2D
onready var Arrow = load("res://Arrow/Arrow.tscn")

func _ready():
	pass


func create_arrow():
	print(1)
	var arrow = Arrow.instance()
	add_child(arrow)
