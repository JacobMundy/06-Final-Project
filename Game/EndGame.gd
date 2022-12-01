extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label/Label.text = "And died " + str(Global.deaths) + " times lol"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
