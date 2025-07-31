extends Node2D

@onready var radius = $RigidBody2D/CollisionShape2D.shape.radius


func _ready():
	pass
	
func _physics_process(delta):
	myphys_apply_inverse_parent(delta)
	
func myphys_apply_inverse_parent(delta:float) -> void:
	"keep my position aligned with my phyics child, pretend `self` is a child of `RigitBody2D`"
	self.position += $RigidBody2D.position
	$RigidBody2D.position = Vector2(0.,0.)

func on_bump(other:PhysicsBody2D):
	#print("monkeybars.gd",self,".on_click(",other,")")
	pass
	
