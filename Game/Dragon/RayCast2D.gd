extends RayCast2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func check():
	var collider = get_collider()
	
	if collider != null:
		print(collider.name)
		return collider.name == "Player"
	else:
		return false
