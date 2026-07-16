class_name MonkePlayer
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
		#body.move_and_slide()
		var was_accel = acceleration
		var was_vel = velocity * 1.0
		var was_pos = position
		body.move_and_collide(velocity)
		
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
		if other_obj.has_method("on_bump"):
			other_obj.on_bump(self)
	
	acceleration *= (0.95) # dampening
	velocity *= (0.95) # dampening
	
	var pos = self.position
	var mouse = get_viewport().get_mouse_position()
	var look_vect = pos - mouse
	$Node2D/TorsoSprite.rotation = look_vect.angle()

@onready var debug_line = $"../debug/Line2D"

func _ready():
	print(get_path())
	step_ticker = 0

@onready var pillars = $"../pillars"

func _process(_delta):
	if step_ticker <= 0:
		_leg_step()
		step_ticker = step_dist
		$Node2D/LegsSprite/LegsSpriteAnimation/FootstepPlayer.play()
	step_ticker -= velocity.length() * _delta
	
func _leg_step():
	# we'll have a ticker that ticks down every <time> by a multiple of the velocity
	# and when this timer reaches zero, we'll run this code
	# it's possible this would be better served by just tracking the distance moved
	# but this is what i thought of!
	$Node2D/LegsSprite/LegsSpriteAnimation.flip_h = false if $Node2D/LegsSprite/LegsSpriteAnimation.flip_h else true

func on_bump(other:PhysicsBody2D):
	print("player.gd",self,".on_click(",other,")")
	pass
