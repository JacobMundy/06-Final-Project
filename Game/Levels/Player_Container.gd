extends Node2D

onready var Player = load("res://Player/Player.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not has_node("Player"):
		var player = Player.instance()
		add_child(player)
		player.get_node("Camera2D").current = true
