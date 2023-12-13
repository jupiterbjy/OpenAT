extends Node


var _entry: Dictionary = {}


func _ready():
	var file = FileAccess.open("res://Models/terrain_info.json", FileAccess.READ)
	var temp_entry: Dictionary = JSON.parse_string(file.get_as_text())
	
	# convert to vector2
	for key in temp_entry:
		var temp_arr: Array[Vector2] = []
		
		for arr in temp_entry[key]:
			temp_arr.append(Vector2(arr[0], arr[1]))
		
		_entry[key] = temp_arr
	
	print("[CollisionLoader] Read %s entries" % len(_entry))


func get_area(model_name: String) -> Array[Vector2]:
	return _entry[model_name]
