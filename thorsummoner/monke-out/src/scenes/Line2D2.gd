extends Line2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var window_size = get_window().size
	var window_bounds = self
	window_bounds.clear_points()
	window_bounds.add_point(Vector2(0-self.position.x, 0-self.position.y), 0)
	window_bounds.add_point(Vector2(window_size.x-self.position.x, 0-self.position.y), 1)
	window_bounds.add_point(Vector2(window_size.x-self.position.x, window_size.y-self.position.y), 2)
	window_bounds.add_point(Vector2(0-self.position.x, window_size.y-self.position.y), 3)
	window_bounds.add_point(Vector2(0-self.position.x, 0-self.position.y), 5)
	pass
