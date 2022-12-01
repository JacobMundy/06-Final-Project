extends Node2D

onready var Player = load("res://Player/Player.tscn")


func _ready():
	pass
	
func _physics_process(_delta):
	if not has_node("Player"):
		var player = Player.instance()
		add_child(player)
		$Player.position.x += 150
		$Player.position.y += 150
		print(player)
