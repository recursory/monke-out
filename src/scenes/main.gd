extends Node2D

func _ready() -> void:
	print(['main:_ready:', 'Hello World',
		'Name:', ProjectSettings.get_setting('application/config/name'),
		'Version:', ProjectSettings.get_setting('application/config/version'),
	])
	State.initialize()

func _process(delta: float) -> void:
	var all_zombies = find_children("*").filter(func(node): return node is mo_Zomby)

	for zomby in all_zombies:
		zomby.target = $player.position
