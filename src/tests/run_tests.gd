# run with ./run_tests from "src" project directory
extends SceneTree

func _initialize():
	print("big stinky")
	var ok = true
	var trace = {"failures": [], "tree": self};
	ok = ok and (load("res://tests/test_leg_step.gd").new()._test(trace))
	ok = ok and (load("res://tests/test_bullet.gd").new()._test(trace))
	if ok:
		print(" ===== ✅ ALL TESTS PASS ===== ")
	else:
		print(" ===== ❌ TESTS FAILED ===== ")
		print(trace)
	quit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
