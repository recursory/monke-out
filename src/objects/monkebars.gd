extends Node2D

@onready var radius = $RigidBody2D/CollisionShape2D.shape.radius
var position2
var position3

func _ready():
	pass
	
func _physics_process(_delta):
	position2 = $RigidBody2D.position + self.position
#	pass

func on_click(other):
	print("monkeybars.gd",self,".on_click(",other,")")
