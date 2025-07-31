extends CharacterBody2D

@export var speed: float = 200.0 # pixels per second

var acceleration = Vector2()
var step_ticker
@export var step_dist: float = 60
@onready var body = self

# todo loading screen during this startup time cost
@onready var dep_my_costmarker : PackedScene = preload("res://devtools/costmarker.tscn")
@onready var dep_my_debugline : PackedScene = preload("res://devtools/debugline.tscn")

const my_collision_mask_SCREEN : int = 2
@export var mymass: float = 1.0 # kg
func get_input():
	var jolt = Vector2()
		
	if Input.is_action_pressed("ui_right") or Input.is_key_pressed(KEY_D):
		jolt.x += 1
	if Input.is_action_pressed("ui_left") or Input.is_key_pressed(KEY_A):
		jolt.x -= 1
	if Input.is_action_pressed("ui_down") or Input.is_key_pressed(KEY_S):
		jolt.y += 1
	if Input.is_action_pressed("ui_up") or Input.is_key_pressed(KEY_W):
		jolt.y -= 1
	acceleration += jolt.normalized() * speed


func _physics_process(delta):
	get_input()
	velocity += (acceleration * delta)
	$Node2D/LegsSprite.rotation = velocity.angle()
	var travel = velocity*delta
	var hittest: KinematicCollision2D = body.move_and_collide(travel, true)
	if not hittest:
		body.move_and_slide()
	else: # hittest
		# how to solve a good feeling collision?
		var collision_left = velocity * mymass
		var collision_right = null
		var other = hittest.get_collider()
		if other is RigidBody2D:
			collision_right = hittest.get_collider_velocity() * hittest.get_collider().mass
		elif other is StaticBody2D:
			collision_right = null # inf resistance?
		else:
			push_error('player._physics_process: NotImplementedError:  collision with {0}'.format([other]))
		var partial_travel = hittest.get_travel()
		#body.move_and_slide()
		var was_accel = acceleration
		var was_vel = velocity * 1.0
		var was_pos = position
		body.move_and_collide(velocity)
		var realized_travel = (position - was_pos)
		
		acceleration = velocity - was_vel
		velocity = position - was_pos
		
		var delta_v : Vector2 = velocity - was_vel
		var delta_a : Vector2  = acceleration - was_accel
		var magnitude : float = delta_v.length()
		
		var do_costmarker : bool = magnitude > 10.0
		if do_costmarker:
			var costmarker = dep_my_costmarker.instantiate()
			costmarker.position = self.position
			costmarker.text = "Ouch! (M {2}, △V {0}, △A {1})".format([
				round(delta_v * 1000.)/1000.,
				round(delta_a * 1000.)/1000.,
				magnitude,
			])
			self.get_parent().add_child(costmarker)
		
		
		# logical collision
		var other_obj = other.get_parent()
		#print("player.gd._physics_process:hittest:", hittest, ":", other_obj, ".on_bump(", self, ")")
		other_obj.on_bump(self)
	
	acceleration *= (0.95) # dampening
	velocity *= (0.95) # dampening
	
	_physics_process2(delta)
	#print(delta, ", ", velocity_)
	var pos = self.position
	var mouse = get_viewport().get_mouse_position()
	#print(pos)
	#print(mouse)
	var look_vect = pos - mouse
	$Node2D/TorsoSprite.rotation = look_vect.angle()

@onready var debug_line = $"../debug/Line2D"

var debugline_player_to_left = null
var debugline_player_to_right = null
var debugline_player_to_left_extended = null
var debugline_player_to_right_extended = null
var debugline_player_to_left_raycast_test = null
var debugline_player_to_left_raycast_result = null
func _ready():
	tripline = Line2D.new()
	$"../debug".add_child(tripline)
	tripline.visible = false # introducing new debugline devtool instead
	
	#debug_line.position = body.position  + Vector2(50, 50)
	#print(debug_line.position, ", ", body.position)
	debugline_player_to_left = dep_my_debugline.instantiate()
	debugline_player_to_right = dep_my_debugline.instantiate()
	debugline_player_to_left_extended = dep_my_debugline.instantiate()
	debugline_player_to_right_extended = dep_my_debugline.instantiate()
	debugline_player_to_left_raycast_test = dep_my_debugline.instantiate()
	debugline_player_to_left_raycast_result = dep_my_debugline.instantiate()
	$"../debug".add_child(debugline_player_to_left)
	$"../debug".add_child(debugline_player_to_right)
	$"../debug".add_child(debugline_player_to_left_extended)
	$"../debug".add_child(debugline_player_to_right_extended)
	$"../debug".add_child(debugline_player_to_left_raycast_test)
	$"../debug".add_child(debugline_player_to_left_raycast_result)
	step_ticker = 0

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
		var delta2 = body.position - child.position
		var atan3 = atan2(delta2.x, delta2.y)
		left = left.rotated(-atan3)
		right = right.rotated(-atan3)
		
		debug_line.add_point(child.position + left, 0)
		debug_line.add_point(child.position + right, 1)
		debug_line.add_point(body.position, 2)
		left_vect = Vector2(left + child.position)
		child_pos = child.position
		right_vect = Vector2(right + child.position)
		
		if step_ticker <= 0:
			_leg_step()
			step_ticker = step_dist
			print("pooP")
		step_ticker -= velocity.length() * _delta
		break
		
var tripline
func _physics_process2(_delta):
	var space_state = get_world_2d().direct_space_state
	var ray_startpoint : Vector2
	var ray_endpoint : Vector2
	
	if 'tripline debug':
		tripline.clear_points()
		if !left_vect:
			return
		#var hittest: KinematicCollision2D = body.move_and_collide(velocity_)
		#endpoint = -(body.position - left_vect) + child_pos 

		tripline.add_point(Vector2(left_vect.x,left_vect.y), 0)
		tripline.add_point(ray_endpoint, 1)
	
	if 'debugline debug':
		debugline_player_to_left.arrowtail = self.position
		debugline_player_to_left.arrowhead = left_vect
		
		debugline_player_to_right.arrowtail = self.position
		debugline_player_to_right.arrowhead = right_vect
		
		debugline_player_to_left_extended.arrowtail = left_vect
		debugline_player_to_left_extended.arrowhead = left_vect + (((left_vect - self.position).normalized()) * 30.0)
		
		debugline_player_to_right_extended.arrowtail = right_vect
		debugline_player_to_right_extended.arrowhead = right_vect + (((right_vect - self.position).normalized()) * 30.0)
		
		debugline_player_to_left_raycast_test.arrowtail =  left_vect + (((left_vect - self.position).normalized()) * 30.0)
		debugline_player_to_left_raycast_test.arrowhead =  left_vect + (((left_vect - self.position).normalized()) * 1000.0)
		ray_startpoint = debugline_player_to_left_raycast_test.arrowtail
		ray_endpoint = debugline_player_to_left_raycast_test.arrowhead
	
	var query = PhysicsRayQueryParameters2D.create(ray_startpoint, ray_endpoint, my_collision_mask_SCREEN)
	
	var result : Dictionary = space_state.intersect_ray(query)
	debugline_player_to_left_raycast_test.visible = result.is_empty()
	debugline_player_to_left_raycast_result.visible = not result.is_empty()
	if result:
		#print("Hit at point: ", result.position)
		
		debugline_player_to_left_raycast_result.arrowtail = debugline_player_to_left_raycast_test.arrowtail
		debugline_player_to_left_raycast_result.arrowhead = result.position
	
func _leg_step():
	# we'll have a ticker that ticks down every <time> by a multiple of the velocity
	# and when this timer reaches zero, we'll run this code
	# it's possible this would be better served by just tracking the distance moved
	# but this is what i thought of!
	
	$Node2D/LegsSprite/LegsSpriteAnimation.flip_h = false if $Node2D/LegsSprite/LegsSpriteAnimation.flip_h else true
