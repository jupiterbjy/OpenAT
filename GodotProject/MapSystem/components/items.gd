class_name MapItems
extends Node3D


var drop_scene: PackedScene = preload("res://ItemSystem/Items/item_dropper.tscn") 
var item_map: Dictionary = {}
var item_dropping: Dictionary = {}
var max_item_count: int = 10


func pick_random() -> Vector2:
	var level: Level = SceneSignals.current_scene.get_child(0)
	
	var available_positions: Array[Vector2] = []
	var size = MapJsonLoader.current_loaded["size"]
	
	# kinda dumb, but cache all open areas for dropping
	for row in range(4, size[1] - 4):
		for col in range(4, size[0] - 4):
			var pos = Vector2(col, row)
			
			if level.passable_tiles[row][col] and pos not in item_map and pos not in item_dropping:
				available_positions.append(pos)
	
	return available_positions.pick_random()


func drop_item():
	if len(item_map) + len(item_dropping) >= 10:
		print("[ItemManager] Max item limit reached")
		return
	
	var dropper = drop_scene.instantiate()
	var drop_pos = pick_random()
	
	print("[ItemManager] Dropping item")
	
	item_dropping[drop_pos] = null
	
	dropper.position = Vector3(drop_pos.x, 0, drop_pos.y)
	add_child(dropper)


func parse_json():
	pass


func clear_item_pos(item: BaseItem):
	item_map.erase(Vector2(item.position.x, item.position.z))


func _ready():
	ItemSignals.drop_requested.connect(drop_item)
	MapSignals.item_taken.connect(clear_item_pos)
