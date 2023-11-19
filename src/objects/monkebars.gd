extends Node2D

@onready var radius = $RigidBody2D/CollisionShape2D.shape.radius
var position2
func _physics_process(_delta):
	position2 = $RigidBody2D.position + self.position
#	pass
