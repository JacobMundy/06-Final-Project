extends KinematicBody2D

var speed = 3
var gravity = 1
var direction = 1

var max_move = 4

var current_state = "idle"

var idle
var running
var jump_force = 20
var max_jump = 20
var jump = 1
var double_jump
var velocity = Vector2.ZERO

func _ready():
	pass 

func _physics_process(delta):
	position.x += velocity.x
	position.y += clamp(velocity.y,-max_jump,max_jump)
	var down = is_on_floor()
	var wall = touching_wall()
	if wall == true:
		velocity.x = 0
	if down == false:
		velocity.y += gravity
	if down == true:
		jump = 0
		velocity.y = 0
	velocity.x = clamp(velocity.x,-max_move,max_move)
	
	if Input.is_action_pressed("Left") and Input.is_action_pressed("Right"):
		idle()

	if Input.is_action_pressed("Right"):
		direction = 1
		running()
	
	if Input.is_action_pressed("Left"):
		direction = -1
		running()
	
	if Input.is_action_pressed("Jump"):
		if jump == 0:
			jump()
	
	if Input.is_action_just_pressed("Jump") and not is_on_floor():
		if jump == 1:
			velocity.y -= jump_force + velocity.y
			jump = 2
	
	if not Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
		velocity.x = 0
	
	if touching_celling():
		velocity.y = clamp(velocity.y, 0, jump_force)

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
	print("yes")
	if jump == 0:
		velocity.y -= jump_force
		jump = 1

func die():
	queue_free()


