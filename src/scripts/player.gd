extends KinematicBody2D



export (int) var speed = 2.0

var velocity = Vector2()
onready var body = self

func get_input():
	var jolt = Vector2()
	if Input.is_action_pressed("right"):
		jolt.x += 1
	if Input.is_action_pressed("left"):
		jolt.x -= 1
	if Input.is_action_pressed("down"):
		jolt.y += 1
	if Input.is_action_pressed("up"):
		jolt.y -= 1
	velocity += jolt.normalized() * speed

func _physics_process(delta):
	get_input()
	var hittest = body.move_and_collide(velocity)
	if hittest:
		velocity *= 0
		print(hittest)
	
	velocity *= 0.9
	#print(delta, ", ", velocity)

onready var debug_line = $"../debug/Line2D"
func _ready():
	#debug_line.position = body.position  + Vector2(50, 50)
	#print(debug_line.position, ", ", body.position)
	pass

onready var pillars = $"../pillars"
func _process(delta):
	debug_line.clear_points()
	debug_line.add_point(body.position)
	
	for child in pillars.get_children():
		var left = Vector2(-child.radius, 0)
		var right = Vector2(child.radius, 0)
		var delta2 = body.position - child.position2
		var atan3 = atan2(delta2.x, delta2.y)
		left = left.rotated(-atan3)
		right = right.rotated(-atan3)
	
		debug_line.add_point(child.position2 + left)
		debug_line.add_point(child.position2 + right)
		debug_line.add_point(body.position)
	
		
