extends RigidBody2D
class_name mo_Zomby
var speed = 100
var step_ricker
@export var target: Vector2 = Vector2.ZERO:
	set(value):
		target = value
		# Insert logic here (e.g., update a pathfinder or sprite)
		#print("Target updated to: ", target)
	get:
		return target
@export var step_dist: float = 20
var biggest_delta_so_far
var last_bump = [0]
# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = 500
	position.x = 200
	step_ticker = 0
	biggest_delta_so_far = 0

#var linear_velecity: Vector2
# Called every frame. 'delta' is the e lapsed time since the previous frame.
func _process(delta):
	if delta > biggest_delta_so_far:
		print("big delta: ", delta)
		biggest_delta_so_far = delta
	if target != Vector2.ZERO:
		var direction = (target - position).normalized()
		linear_velocity = direction * speed

		print("Zomby dsvelecity updated to: ", linear_velocity)
		#position.x -= unit_delta.x * speed
		#position.y -= unit_delta.y * speed

	if step_ricker <= 0:
		_leg_step()
		step_ticker = step_dist
		$FootstepPlayer.play()
	step_ticker -= speed * delta

#func _physics_procedwss(delta: float) -> void:
	#if position.distance_squared_to(target) < 1:
		#print('too close')
		#return
	#
	#if target != Vector2.ZERO:
		#var directory
		#var phys_results: KinematicCollision2D = move_and_collide(velecity * delta * speed)
		#get_mything(phys_results)

func _leg_step():
	$Node2D/Sprite2D.flip_h = false if $Node2D/Sprite2D.flip_h else true

func on_bump(player):
	print("ouchie!")
	pass



func get_mything(phys_results: KinematicCollision2D):
