
# Called when the node enters the scene tree for the first time.
func _ready():
	print("Hello World")

func _test():
	var player = preload("res://objects/player.tscn").instantiate()
	print(typeof(player))
	test_player_leg_step(player)
	player.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func test_player_leg_step(player : MonkePlayer):
	print("nuclear test:")
	var anim : Sprite2D = player.get_node("Node2D/LegsSprite/LegsSpriteAnimation")
	var flip_status : bool = anim.flip_h
	player._leg_step()
	assert(flip_status != anim.flip_h, "baby fell on 1st step")
	player._leg_step()
	assert(flip_status == anim.flip_h, "baby fell on 2nd step")
	print("crisis averted!")
	pass
