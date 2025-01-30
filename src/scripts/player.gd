extends CharacterBody2D

@export var speed: float = 2.0

var velocity_ = Vector2()
@onready var body = self

func get_input():
	var jolt = Vector2()
	if Input.is_action_pressed("ui_right"):
		jolt.x += 1
	if Input.is_action_pressed("ui_left"):
		jolt.x -= 1
	if Input.is_action_pressed("ui_down"):
		jolt.y += 1
	if Input.is_action_pressed("ui_up"):
		jolt.y -= 1
	velocity_ += jolt.normalized() * speed


func _physics_process(_delta):
	get_input()
	var hittest: KinematicCollision2D = body.move_and_collide(velocity_)
	if hittest:
		velocity_ *= 0
		var other = hittest.get_collider().get_parent()
		print("player.gd._physics_process:hittest:", hittest, ":", other, ".on_click(", self, ")")
		#hittest.get_collider().get_parent()._ready()
		other.on_click(self)
	
	velocity_ *= 0.9
	
	_physics_process2(_delta)
	#print(delta, ", ", velocity_)

@onready var debug_line = $"../debug/Line2D"
func _ready():
	tripline = Line2D.new()
	$"../debug".add_child(tripline)
	#debug_line.position = body.position  + Vector2(50, 50)
	#print(debug_line.position, ", ", body.position)
	pass

@onready var pillars = $"../pillars"
@onready var window_bounds = $"../debug/Line2D2"
var left_vect
var right_vect
var child_pos
func _process(_delta):
	debug_line.clear_points()
	debug_line.add_point(body.position)
	
	for child in pillars.get_children():
		var left = Vector2(-child.radius, 0)
		var right = Vector2(child.radius, 0)
		var delta2 = body.position - child.position2
		var atan3 = atan2(delta2.x, delta2.y)
		left = left.rotated(-atan3)
		right = right.rotated(-atan3)
		
		debug_line.add_point(child.position2 + left, 0)
		debug_line.add_point(child.position2 + right, 1)
		debug_line.add_point(body.position, 2)
		left_vect = Vector2(left + child.position2)		
		child_pos = child.position2
		right_vect = Vector2(right + child.position2)
		break
var tripline
func _physics_process2(_delta):
	tripline.clear_points()
	if !left_vect:
		return
	#var hittest: KinematicCollision2D = body.move_and_collide(velocity_)
	var space_state = get_world_2d().direct_space_state
	var endpoint: Vector2 = -(body.position - left_vect) + child_pos 

	var query = PhysicsRayQueryParameters2D.create(left_vect, endpoint)
	tripline.add_point(Vector2(left_vect.x,left_vect.y), 0)
	tripline.add_point(endpoint, 1)
	
	var result = space_state.intersect_ray(query)
	if result:
		print("Hit at point: ", result.position)
	
