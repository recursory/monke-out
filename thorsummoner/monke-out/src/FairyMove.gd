extends Node2D

@export
var period :float =.2 :set=SetPeriod
func SetPeriod(period:float):
	$FairySprite.period = period

@export
var lightColor :Color :set=SetLightColor
func SetLightColor(color:Color):
	$FairySprite.lightColor = color

@export
var spinSpeed : float = 1.0 :set=SetSpinSpeed
func SetSpinSpeed(spinSpeed2:float):
	spinSpeed = spinSpeed2
	#print("spinSpeed 1,2: ", spinSpeed, ",", spinSpeed2)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$".".rotation += (delta * spinSpeed)
	$FairySprite.rotation -= (delta * spinSpeed)
	#(spinSpeed)
	if fmod($".".rotation, 2.0*PI) > PI:
		$FairySprite.scale.x = -1
	else:
		$FairySprite.scale.x = 1
	pass
