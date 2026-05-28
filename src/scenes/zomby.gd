extends RigidBody2D
class_name mo_Zomby
var speed = 5
var step_ticker
@export var target: Vector2 = Vector2.ZERO:
	set(value):
		target = value
		# Insert logic here (e.g., update a pathfinder or sprite)
		#print("Target updated to: ", target)
	get:
		return target
@export var step_dist: float = 1
var biggest_delta_so_far
var last_bump = [0]
# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = 500
	position.x = 200
	step_ticker = 0
	biggest_delta_so_far = 0

# Called every frame. 'delta' is the e lapsed time since the previous frame.
func _process(delta):
	if delta > biggest_delta_so_far:
		print("big delta: ", delta)
		biggest_delta_so_far = delta
	if target != Vector2.ZERO:
		var direction = (target - position).normalized()
		linear_velocity = direction * speed

		#print("Zomby dsvelecity updated to: ", linear_velocity)
		#position.x -= unit_delta.x * speed
		#position.y -= unit_delta.y * speed

	if step_ticker <= 0:
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
	State.handle_collision(phys_results, self, last_bump)

	#if phys_results == null:
		#return
	#if last_bump == phys_results.get_collider_id():
		#return
	#last_bump = phys_results.get_collider_id()
	#var other = phys_results.get_collider()
	#if other.has_method("on_bump"):
		#other.on_bump(self)
		#return
	#else:
		#assert(false, other.get_path())

	#var other_parent:Node2D = other.get_parent()
	##print(other_parent)
	#if other_parent.to_string().contains("main"):
		#return
	#if other_parent.has_method("on_bump"):
		#other_parent.on_bump(self)
		#return
		# if other has onbump call it, if other_parent has onbump call it,
			# if other parent is main, don't call it

#func get_mything2(phys_results: KinematicCollision2D):
	##decide if other thing is packaged or not
	#if phys_results == null:
		#return
	#if phys_results.get_collider().has_method("on_bump"):
		#if phys_results.get_collider().to_string().contains("main"):
			#return
		#return phys_results.get_collider()
	#if phys_results.get_collider().get_parent().has_method("on_bump"):
		#if phys_results.get_collider().get_parent().to_string().contains("main"):
			#return
		#return phys_results.get_collider().get_parent()
	#return


