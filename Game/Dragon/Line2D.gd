extends Line2D
var ready = true
var target
var checking = false
func _ready():
	pass 

func _physics_process(_delta):
	if checking == true:
		if $RayCast2D.check() == true:
			var player = get_node_or_null("/root/Game/Player_Container/Player")
			player.die()

func start():
	if ready == true:
		modulate = Color(0,255,1)
		var player = get_node_or_null("/root/Game/Player_Container/Player/Sprite")
		target = player.global_position-global_position
		set_points([Vector2(0,0),target,100*target])
		visible = true
		ready = false
		$LaserTimer.start()

func _on_LaserTimer_timeout():
	$RayCast2D.cast_to = target * 100
	checking = true
	modulate = Color(0,0,255,1)
	$ShootingTimer.start()

func _on_ShootingTimer_timeout():
	visible = false
	ready = true
	checking = false
