class_name FlagTile extends BaseHealthedTile


@onready var healthbar: HealthBar = $health_bar

var tile_pos: Vector2


func setup(config: Array, map_height):
	# flag tile is in reverse Y
	tile_pos = Vector2(config[0], map_height - 1 - config[1])
	
	setup_tile(tile_pos, config[2], "", "", config[3], "", Raycasts.layers["Healthed"])
	healthbar.setup(350)


func get_damage(amount: int):
	healthbar.get_damage(amount)


func _on_health_bar_destroyed():
	MapSignals.game_over.emit()
