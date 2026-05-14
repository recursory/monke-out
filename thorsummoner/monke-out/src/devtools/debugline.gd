extends Node2D

@export
var arrowtail : Vector2 = Vector2(0,0) : set = my_set_arrowtail
var arrowhead : Vector2 = Vector2(100,100) : set = my_set_arrowhead

func _ready() -> void:
	pass

const update_freq : float = 1.0/24 # 24 fps
var delta_last_update : float = 0
func _process(delta: float) -> void:
	delta_last_update += delta
	if delta_last_update > update_freq:
		my_update(delta_last_update)
		delta_last_update -= update_freq


func my_set_arrowtail(value:Vector2):
	arrowtail = value
	my_update(0.)

func my_set_arrowhead(value:Vector2):
	arrowhead = value
	my_update(0.)

func power(value:float, exponent:float):
	return value ** exponent
	
func roundfp(value:float, digits:int):
	var adjust = power(10, digits)
	return (roundf(value * adjust) / adjust)

func my_update(delta):
	$arrowbody.set_point_position(0, arrowtail)
	$arrowbody.set_point_position(1, arrowhead)
	$arrowtail_info.position = arrowtail
	$arrowtail_info.text = "\nTail Vector2({0}, {1})".format([roundfp(arrowtail.x,3), roundfp(arrowtail.y, 3)])
	
	var arrow_direction = (arrowhead - arrowtail).normalized()
	var arrowhead_wing_left = Vector2(10, 0).rotated(arrow_direction.angle() - (PI/6))
	var arrowhead_wing_right = Vector2(10, 0).rotated(arrow_direction.angle() + (PI/6))
	$arrowhead.set_point_position(0, arrowhead - arrowhead_wing_left)
	$arrowhead.set_point_position(1, arrowhead)
	$arrowhead.set_point_position(2, arrowhead - arrowhead_wing_right)
	$arrowhead_info.position = arrowhead
	$arrowhead_info.text = "Head Vector2({0}, {1})".format([roundfp(arrowhead.x, 3), roundfp(arrowhead.y, 3)])
