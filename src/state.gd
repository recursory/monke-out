extends Node

func initialize():
	print("Hello world!")

func handle_collision(phys_results: KinematicCollision2D, _self: CollisionObject2D, last_bump: Array):
	if phys_results == null:
		return
	if last_bump[0] == phys_results.get_collider_id():
		return
	last_bump[0] = phys_results.get_collider_id()
	var other = phys_results.get_collider()
	if other.has_method("on_bump"):
		other.on_bump(_self)
		return
	else:
		assert(false, other.get_path())
