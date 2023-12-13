class_name BaseHealthedTile extends BaseTile


@onready var _health_bar: HealthBar = $health_bar


signal destroyed(tile_pos: Vector2)


## action on zero-health
func destroy():
	pass


## action on hit
func on_hit(damage: int, is_enemy: bool, is_electric: bool = false):
	# no action for base tile / terrain tiles
	
	if not _health_bar.get_damage(damage):
		destroyed.emit(pos)
		destroy()
