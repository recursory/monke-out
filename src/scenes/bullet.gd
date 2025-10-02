extends RigidBody2D

var bullet_speed = 20

func _ready():
	#visible = false
	#collision_mask = 0
	position.x = 0
	position.y = 0

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed():
		var player = $/root/main/player
		#visible = true
		position = player.position
		self.rotation = (player.position-event.position).angle()
		print("bang!")
		
func _process(delta):
	var direction = Vector2(-1, 0)
	direction = direction.rotated(self.rotation)
	position = position + direction * bullet_speed * delta
	var results = move_and_collide(direction * bullet_speed * delta)
	#if results != null:
	#	print(results)
	pass
	
