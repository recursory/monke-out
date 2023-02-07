extends KinematicBody2D



export (int) var speed = 200

var velocity = Vector2()
onready var body = self

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = body.move_and_slide(velocity)
	#print(delta, ", ", velocity)

onready var debug_line = $"../debug/Line2D"
func _ready():
	#debug_line.position = body.position  + Vector2(50, 50)
	#print(debug_line.position, ", ", body.position)
	pass

onready var walls = $"../walls"
func _process(delta):
	debug_line.clear_points()
	debug_line.add_point(body.position)
	
	for child in walls.get_children():
		var left = Vector2(-child.radius, 0)
		var right = Vector2(child.radius, 0)
		var delta2 = body.position - child.position
		var atan3 = atan2(delta2.x, delta2.y)
		left = left.rotated(-atan3)
		right = right.rotated(-atan3)
	
		debug_line.add_point(child.position + left)
		debug_line.add_point(child.position + right)
		debug_line.add_point(body.position)
	
		
