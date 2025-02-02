extends Node2D

@export var text : String = "SetMe" : set = my_settext
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play('my_cost')

func my_settext(value:String):
	text = value
	$Node2D/RichTextLabel.text = text

var elapsed : float = 0
func _process(delta: float) -> void:
	elapsed += delta
	if elapsed > 3.0:
		mykill()

func mykill() -> void:
	self.get_parent().remove_child(self)
	self.queue_free()
