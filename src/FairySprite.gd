extends Node2D

@export
var period :float = .2

@export
var lightColor :Color :set=SetLightColor
func SetLightColor(color:Color):
	$PointLight2D.color = color
	
var spriteArr
# Called when the node enters the scene tree for the first time.
func _ready():
	spriteArr = [
		$LadxGreatFairySprite01,
		$LadxGreatFairySprite02,
		$LadxGreatFairySprite03, 
		$LadxGreatFairySprite04, 
		$LadxGreatFairySprite05, 
		$LadxGreatFairySprite06, 
		$LadxGreatFairySprite07, 
		$LadxGreatFairySprite08, 
		$LadxGreatFairySprite09, 
		$LadxGreatFairySprite10, 
		$LadxGreatFairySprite11, 
		$LadxGreatFairySprite12, 
		$LadxGreatFairySprite13, 
		$LadxGreatFairySprite14, 
		$LadxGreatFairySprite15, 
		$LadxGreatFairySprite16
	]
	for i in range(0,16):
		spriteArr[i].hide()
	pass # Replace with function body.

var sprite_runtime = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite_runtime += delta
	if(sprite_runtime >= period):
		advanceFrame()
		sprite_runtime -= period
	pass

var current_frame = 0
func advanceFrame():
	spriteArr[current_frame].hide()
	current_frame = (current_frame + 1) % 16
	spriteArr[current_frame].show()
