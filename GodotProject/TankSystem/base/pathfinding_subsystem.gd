class_name PathfindingSubSystem
extends Node


var _level: Level = SceneSignals.current_scene.get_child(0)


## 'Forward' Movement offset you can just add. Order is N-W-S-E
static var _forward_map = [
	Vector2(0, -1),
	Vector2(-1, 0),
	Vector2(0, 1),
	Vector2(1, 0),
]


enum TYPE {ALLIE, ENEMY, BOSS}


## checks if a tile is target
func is_target(target_pos: Vector2, level: Level, type: TYPE) -> bool:
	match type:
		TYPE.ENEMY:
			if target_pos in level.walls.target_clusters:
				# found wall to kickin'
				return true
				
			if "F" not in _level.game_type and level.tanks[1][target_pos.y][target_pos.x] > 0:
				# found allie tank to mess with
				return true
			
			return false

		TYPE.ALLIE:
			if level.tanks[0][target_pos.y][target_pos.x] > 0:
				# found enemy tank to mess with
				return true
			
			if target_pos in level.items.item_map:
				# found item to take
				return true

		TYPE.BOSS:
			if level.tanks[1][target_pos.y][target_pos.x] > 0:
				# found allie tank to mess with
				return true
			
			return false
	
	return false


func is_in_boundary(target_pos: Vector2):
	if not (0 <= target_pos.x and target_pos.x < MapJsonLoader.current_loaded["size"][1]):
		return false
	
	return 0 <= target_pos.y and target_pos.y < MapJsonLoader.current_loaded["size"][0]


## BFS from start position to target position
## will return Array[Vector2] incl. target pos if path is found else empty Array
func bfs(start_pos: Vector2, type: TYPE, ignore: Dictionary = {}) -> Array[Vector2]:
	
	# visited dict acting as hashset. There is no hashset in gdscript yet.
	# https://github.com/godotengine/godot-proposals/issues/867
	var visited: Dictionary = {
	}
	
	# parent cache storing which node was visited from which.
	# will be used to reconstruct full path after finding goal.
	var parent: Dictionary = {
		start_pos: null,
	}
	
	var queue: Array[Vector2] = [start_pos]
	
	while queue:
		var next_node = queue.pop_front()
		
		# mark as visited
		visited[next_node] = null
		
		# check surrounding and insert to queue, if not visited & passable
		for offset in _forward_map:
			var adj_node = next_node + offset

			# if visited or ignore skip
			if not is_in_boundary(adj_node) or adj_node in visited or adj_node in ignore:
				continue
			
			# if target rebuild path and return
			if is_target(adj_node, _level, type):
				var path: Array[Vector2] = [adj_node, next_node]
				
				while parent[next_node] != null:
					next_node = parent[next_node]
					
					path.append(next_node)
				
				path.pop_back()
				return path
			
			# if is an inaccessible tile skip
			if not _level.passable_tiles[adj_node.y][adj_node.x]:
				continue
			
			# record parent node & enqueue
			parent[adj_node] = next_node
			queue.append(adj_node)
	
	# we couldn't find path, return empty
	return []

