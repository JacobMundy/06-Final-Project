extends KinematicBody2D

var start_pos = [Vector2(700,500),Vector2(300,500),Vector2(100,500),Vector2(500,500)]
var shield_health = 3
var shield_on = true

var health = 3

func _ready():
	randomize()
	rand_pos()

func rand_pos():
	var rand = randi()%4
	position = start_pos[rand]

func shield_hit():
	if shield_on:
		shield_health -= 1
		$Shield.modulate.a = $Shield.modulate.a/2
		rand_pos()
	if shield_health == 0:
		rand_pos()
		$Shield/Sprite.visible = false
		$Shield/CollisionPolygon2D.set_deferred("disabled", true)
		$CollisionPolygon2D.set_deferred("disabled", false)
		shield_on = false
		
func damage():
	health -= 1
	rand_pos()
	shield_on = true
	$Shield/Sprite.visible = true
	$Shield/CollisionPolygon2D.set_deferred("disabled", false)
	$CollisionPolygon2D.set_deferred("disabled", true)
	shield_health = 3
	$Shield.modulate.a = $Shield.modulate.a*8
	if health == 0:
		queue_free()
