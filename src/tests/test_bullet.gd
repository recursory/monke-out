# =================================================================================
# =-{-----------------------------------------------------------------------------=
# =--------------LIB MONKETEST----------------------------------------------------=
# =-----------------------------------------------------------------------------}-=
# =================================================================================

# --- Paste this helper anywhere ---
# run_test(cb) - pass an auto-destroying "spawn" helper function to keep tests
# memory clean.
func run_test(test_logic: Callable) -> void:
	var trash: Array[Node] = []

	# Create the spawn tool as a local closure
	var spawn = func(path: String) -> Node:
		var n = load(path).instantiate()
		trash.append(n)
		return n

	# Run the actual test code and await it
	await test_logic.call(spawn)

	# Automatically clean up everything when the logic finished
	for node in trash:
		if is_instance_valid(node):
			node.queue_free()
# ----------------------------------

# =================================================================================
# =-{-----------------------------------------------------------------------------=
# =--------------TEST BULLET------------------------------------------------------=
# =-----------------------------------------------------------------------------}-=
# =================================================================================

# Your actual test cases (completely self-contained)
func test_bullet_collision(context: Dictionary) -> bool:
	var ret = false;
	await run_test(func(spawn):
		var tree = context['tree'];
		var bullet = spawn.call("res://scenes/bullet.tscn")
		var target = spawn.call("res://scenes/target.tscn")

		target.position = Vector2(10, 0)
		await tree.physics_frame
		bullet.position = Vector2(10, 0)
		await tree.physics_frame

		assert(bullet.has_overlapping_bodies())
		ret = true
	)
	if not ret:
		context['trace'].append('test_bullet_collision')
	return ret

func _test(context: Dictionary) -> bool:
	return await test_bullet_collision(context);
