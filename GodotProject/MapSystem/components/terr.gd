class_name MapTerr
extends Node3D


var tiles: Array[Array] = []
var passable_tiles: Array[Array] = []

var _base: PackedScene = preload("res://MapSystem/base_tiles/base_tile.tscn")


func parse_json():
	print("[TERR] Building terrain")

	var size = MapJsonLoader.current_loaded["size"]
	var converter: Dictionary = MapJsonLoader.current_loaded["terrain_type"]
	
	for row in range(size[1]):
		var temp_arr: Array = []
		var temp_w_arr: Array = []
		var terr_line: PackedStringArray = MapJsonLoader.current_loaded["terrain"][row].split(" ")
		
		for col in range(size[0]):
			
			# fetch tile info & sanity check
			var tile_id: String = terr_line[col * 2]
			
			# run sanity check - if model doesn't exists, it's air - append null and continue
			if tile_id not in converter:
				temp_arr.append(null)
				temp_w_arr.append(true)
				continue
			
			# create tile
			var tile: BaseTile = _base.instantiate()
			
			# run tile configuration
			tile.setup_tile(
				Vector2(col, row),
				converter[tile_id][0],
				converter[tile_id][1],
				terr_line[col * 2 + 1],
				"TERR",
				MapJsonLoader.current_loaded["texture_override"],
			)
			
			temp_arr.append(tile)
			temp_w_arr.append(not tile.water)
			add_child(tile)
		
		passable_tiles.append(temp_w_arr)
		tiles.append(temp_arr)

