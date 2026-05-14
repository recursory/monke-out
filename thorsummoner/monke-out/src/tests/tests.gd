extends SceneTree

func _initialize():
	print("big stinky")
	var tests = load("res://tests/test_leg_step.gd").new()
	print(typeof(tests))
	tests._test()
	quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
