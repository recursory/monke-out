extends Node2D
var speed = 5
var step_ticker
@export var target: Vector2 = Vector2(Vector2.ZERO)
@export var step_dist: float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	position.y = 500
	position.x = 200
	step_ticker = 0
	pass # Replace with function body.

# Called every frame. 'delta' is the e lapsed time since the previous frame.
func _process(delta):
	if target != Vector2.ZERO:
		var target_delta = position - target
		var unit_delta = target_delta.normalized()
		position.x -= unit_delta.x * speed
		position.y -= unit_delta.y * speed
		
	if step_ticker <= 0:
		_leg_step()
		step_ticker = step_dist
		$FootstepPlayer.play()
	step_ticker -= speed * delta

func _leg_step():
	$Node2D/Sprite2D.flip_h = false if $Node2D/Sprite2D.flip_h else true
