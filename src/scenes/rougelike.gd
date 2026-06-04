extends Node2D

# what is a rougelike?
# ====================
# 
# 2. deficultiy goes up over space ( - random shit happens, zombie spawn rate goes up over time)
# 1. procedural generation (depressing suburbs) (- explore an unknown space)
# 3. permanent death

func world_delete():
	$world.hide()
	$world.queue_free()
	
func world_generate(seed):
	# Wave Function Collapse Here
	pass

var quit = false
var dead = false
func game_reset():
	dead = false
	
	world_delete()
	world_generate(0)

var msgbox_waiting = false
func msgbox(msg):
	msgbox_waiting = true
	while not msgbox_waiting:
		if Input.is_action_just_released("ui_accept"):
			msgbox_waiting = false
		else:
			pass # sleep

func mainloop():
	while not quit:
		# new game
		game_reset()
		while not dead:
			msgbox("you died!")
			dead = true
			
		
