extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func on_bump(other:PhysicsBody2D):
	print("monkewall.gd",self,".on_click(",other,")")
	pass
