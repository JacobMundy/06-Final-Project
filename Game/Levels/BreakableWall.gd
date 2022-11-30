extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BreakableWall_area_entered(area):
	var AttackR = get_node_or_null("/root/Game/Player_Container/Player/AttackRight")
	var AttackL = get_node_or_null("/root/Game/Player_Container/Player/AttackRight")
	if "Attack" in area.name and (AttackL.visible == true or AttackR.visible == true):
		var wall = get_node_or_null("/root/Game/DestroyableWall")
		if wall != null:
			wall.queue_free()

