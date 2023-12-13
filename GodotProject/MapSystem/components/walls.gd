class_name MapWalls
extends Node3D


# wallmaps using each wall's absolute cooridnate as key
# two should not connect each other, so split cartegory
var wall_map: Dictionary = {}
var clustors: Array[Array] = []

## Target cluster dictionary. Key: vector2 pos, Val: cluster
var target_clusters: Dictionary = {}


var _wall_cluster_scene: PackedScene = preload("res://WallSystem/wall_cluster.tscn")


func parse_json():
	var data = MapJsonLoader.current_loaded["wall"]
	var size = MapJsonLoader.current_loaded["size"]
	
	# generate map, pair two by one
	for row in range(size[1]):
		var temp_arr = []
		
		for col in range(size[0]):
			# build single string - top left, top right, bottom left, bottome right
			var r = row * 2
			var c = col * 2

			# build string
			var string = data[r][c] + data[r][c + 1] + data[r + 1][c] + data[r + 1][c + 1]
			
			# check if string is empty
			if string == "    ":
				temp_arr.append(null)
				continue
			
			# build cluster
			var cluster: BaseWallCluster = _wall_cluster_scene.instantiate()
			cluster.setup(string, Vector2(col, row), wall_map)
			
			# add to targets if it is
			if cluster.is_target:
				target_clusters[cluster.tile_pos] = cluster
			
			# add child and put in entry
			add_child(cluster)
			temp_arr.append(cluster)
		
		clustors.append(temp_arr)

	# now process wall checks
	for wall in wall_map.values():
		wall.setup_adj(wall_map)


func on_cluster_regen(cluster: BaseWallCluster):
	wall_map[cluster.tile_pos] = cluster
	if cluster.is_target:
		target_clusters[cluster.tile_pos] = cluster


func on_cluster_destroyed(cluster: BaseWallCluster):
	wall_map.erase(cluster.tile_pos)
	
	if cluster.is_target:
		target_clusters.erase(cluster.tile_pos)
