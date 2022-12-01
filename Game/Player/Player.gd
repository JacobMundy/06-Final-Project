extends KinematicBody2D

onready var Arrow = load("res://Arrow/Arrow.tscn")

var speed = 4
var gravity = 1
var direction = 1

var max_move = 9
var max_attack = 3
var current_state = "idle"

var jump_force = 20
var max_jump = 60
var jump_num = 1
var velocity = Vector2.ZERO

var attack_num = 0
var current_attack = 0
var currently_attacking = false
var attack_direction = 0
var attack_cool = 0

var ArrowShot = false

func _ready():
	pass 

func _process(_delta):
	if is_on_floor() == true:
		jump_num = 0
		position.y = clamp(position.y,position.y,10000)
		velocity.y = clamp(velocity.y,-max_jump, 0)
	velocity.x = clamp(velocity.x,-max_move,max_move)
	if touching_celling():
		velocity.y = clamp(velocity.y, 0, jump_force)
	if touching_wall():
		if touching_wall_left():
			velocity.x = clamp(velocity.x,0,max_move)
		if touching_wall_right():
			velocity.x = clamp(velocity.x,-max_move,0)

func _physics_process(_delta):
	position.x += velocity.x
	position.y += clamp(velocity.y,-max_jump,max_jump/3)
	if is_on_floor() == false:
		velocity.y += gravity
		
	if Input.is_action_pressed("Left") and Input.is_action_pressed("Right"):
		idle()

	if Input.is_action_pressed("Right"):
		direction = 1
		running()
	
	if Input.is_action_pressed("Left"):
		direction = -1
		running()
	
	if Input.is_action_just_pressed("Jump"):
		if jump_num == 0:
			jump()
	
	if Input.is_action_just_pressed("Jump") and not is_on_floor():
		if jump_num == 1:
			velocity.y -= jump_force + velocity.y
			jump_num = 2
	
	if not Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
		velocity.x = 0
	
	if Input.is_action_just_pressed("Attack"):
		if max_attack > attack_num and attack_cool == 0:
			attack_num += 1
			Attack()
			
	if Input.is_action_just_pressed("Shoot"):
		if ArrowShot == false:
			Arrow = get_node_or_null("/root/Game/Arrow_Container")
			print(Arrow)
			Arrow.create_arrow()
			ArrowShot = true
			velocity.x -= direction*200
			$ArrowTimer.start()

func _on_ArrowTimer_timeout():
	ArrowShot = false

func Attack():
	if direction == 1 and currently_attacking == false and attack_direction != -1:
		attack_direction = 1
		$AttackTimer1.start()
		$AttackInt.start()
		currently_attacking = true
		current_attack += 1
		print(1)
	
	if currently_attacking == false and attack_direction == -1:
		$AttackTimer1.start()
		$AttackInt.start()
		currently_attacking = true
		current_attack += 1
		print(2)
		
	if direction == -1 and currently_attacking == false  and attack_direction != 1:
		attack_direction = -1
		$AttackTimer1.start()
		$AttackInt.start()
		currently_attacking = true
		current_attack += 1
		print(3)
	
	if currently_attacking == false and attack_direction == 1:
		$AttackTimer1.start()
		$AttackInt.start()
		currently_attacking = true
		current_attack += 1
		print(4)
	
func _on_AttackInt_timeout():
#	print("yes")
	if attack_direction == 1:
		$AttackRight.monitoring = true
		$AttackRight.visible = true
	elif attack_direction == -1:
		$AttackLeft.monitoring = true
		$AttackLeft.visible = true

func _on_AttackTimer1_timeout():
	if attack_num == current_attack:
		$AttackRight.monitoring = false
		$AttackRight.visible = false
		$AttackLeft.monitoring = false
		$AttackLeft.visible = false
		current_attack = 0
		attack_num = 0
		currently_attacking = false
		attack_direction = 0
		attack_cool = 1
		$AttackCool.start()
	else:
		$AttackRight.monitoring = false
		$AttackRight.visible = false
		$AttackLeft.monitoring = false
		$AttackLeft.visible = false
		currently_attacking = false
		Attack()

func _on_AttackCool_timeout():
	attack_cool = 0

func is_on_floor():
	var fl = $Floor.get_children()
	for f in fl:
		if f.is_colliding():
			return true
	return false

func touching_wall():
	var fl = $Wall/Left.get_children() + $Wall/Right.get_children() 
	for f in fl:
		if f.is_colliding():
			return true
	return false
	
func touching_celling():
	var fl = $Celling.get_children()
	for f in fl:
		if f.is_colliding():
			return true
	return false	

func touching_wall_left():
	var fl = $Wall/Left.get_children() 
	for f in fl:
		if f.is_colliding():
			return true
	return false

func touching_wall_right():
	var fl = $Wall/Right.get_children() 
	for f in fl:
		if f.is_colliding():
			return true
	return false

func idle():
	pass
	
func running():
	if touching_wall() == false:
		velocity.x += speed * direction
	if touching_wall_left() == true and direction == 1:
		velocity.x += speed * direction
	if touching_wall_right() == true and direction == -1:
		velocity.x += speed * direction

func jump():
	if jump_num == 0:
		velocity.y -= jump_force
		jump_num = 1

func die():
	queue_free()
