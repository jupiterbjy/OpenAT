class_name MapFlags
extends Node3D


@onready var tile: FlagTile = $flag_tile

var _level: Level


func parse_json():
	tile.setup(MapJsonLoader.current_loaded["flag"], MapJsonLoader.current_loaded["size"][1])

	_level = get_parent().get_parent()

	# add to target
	_level.walls.target_clusters[tile.tile_pos] = tile


func _on_flag_tile_destroyed(_tile_pos):
	MapSignals.game_over.emit()
