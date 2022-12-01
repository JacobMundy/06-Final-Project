extends KinematicBody2D

var start_pos = [Vector2(896,256),Vector2(-640,192),Vector2(-256,-128),Vector2(128,-320),Vector2(576,-64)]
var shield_health = 3
var shield_on = true

var health = 3

func _ready():
	randomize()
	rand_pos()

func _physics_process(_delta):
	var rand = randi()%60
	if rand == 1:
		fireball(3)

func fireball(d):
	for n in d:
		Global.summon_fireball()
func rand_pos():
	var rand = randi()%5
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
