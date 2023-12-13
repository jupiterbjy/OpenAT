extends Node


var _entry: Dictionary = {}
var _base_format: String = "res://Models/Raw/%s.glb"


func _ready():
	var file = FileAccess.open("res://Models/_lookup.json", FileAccess.READ)
	_entry = JSON.parse_string(file.get_as_text())
	print("[ModelLoader] Read %s entries" % len(_entry))


## Checks if name exists
func exists(model_name: String) -> bool:
	return model_name in _entry


## Load model by name
func load_name(model_name: String) -> Node3D:
	if model_name not in _entry:
		print("[ModelLoader] Can't find %s" % model_name)
		return null
	
	var target = _entry[model_name]["file"][0]
	var scale = _entry[model_name]["scale"][0]
	
	# print("[ModelLoader] Instantiating %s scale=%s" % [target, scale])
	
	# load & instantiate model
	var model = load(_base_format % target).instantiate()
	
	# scale - we need to compensate the fact that actual game it mirrors models
	model.scale = Vector3(-scale, scale, scale)
	
	return model
