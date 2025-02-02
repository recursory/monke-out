extends Node2D

func _ready() -> void:
	print(['main:_ready:', 'Hello World', 
		'Name:', ProjectSettings.get_setting('application/config/name'),
		'Version:', ProjectSettings.get_setting('application/config/version'),
	])

func _process(delta: float) -> void:
	my_process_debug(delta)

func my_process_debug(delta: float) -> void:
	my_process_debug_demo_debugline(delta)
	my_process_debug_player_sight(delta)
	
func my_process_debug_demo_debugline(delta: float) -> void:
	$debug/devtools_debugline.arrowtail = Vector2(300, 300) + Vector2(
		(sin(Time.get_ticks_msec() / 1000.0) * 100),
		0.0, # (cos(Time.get_ticks_msec() / 1000.0) * 100),
	)
	$debug/devtools_debugline.arrowhead = Vector2(300, 300) + Vector2(
		0.0, # (sin(Time.get_ticks_msec() / 1000.0) * 100),
		(cos(Time.get_ticks_msec() / 1000.0) * 100),
	)
	
func my_process_debug_player_sight(delta:float) -> void:
	$debug/devtools_debugline2.arrowtail = $player.position
	$debug/devtools_debugline2.arrowhead = $pillars/monkebars.position
