extends Area2D
@export var Bullet : PackedScene

var bullet_speed = 200

func _ready():
	pass
		
func _physics_process(delta: float):
	position += transform.x * bullet_speed * delta
	pass

func on_bump(other:PhysicsBody2D):
	print("bang! ",self,".on_click(",other,")")
	pass

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("zomby"):
		body.queue_free()
	# 'body' is the object you just ran into!
	print("Collided with: ", body.name)
	#queue_free()
	pass
	
func shoot(player : MonkePlayer):
	self.transform = player.torso_sprite.global_transform
	self.global_transform = self.global_transform.rotated(PI/100)	
