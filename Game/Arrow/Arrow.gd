extends Sprite
var direction
var speed = 100

func _ready():
	direction = Global.get_direction()
	position = Global.get_position()
	pass

func _physics_process(_delta):
	position.x += direction * speed

func _on_Area2D_body_entered(body):
	if body.name != "Player" and body.name != "Arrow":
		if body.name == "Dragon":
			Global.damage()
		print(body)
		queue_free()
