extends Node


var _entry: Dictionary = {}
var _base_format: String = "res://Models/Raw/%s.glb"


func _ready():
	var file = FileAccess.open("res://Models/_lookup.json", FileAccess.READ)
	_entry = JSON.parse_string(file.get_as_text())
	print("[ModelLoader] Read %s entries" % len(_entry))


## Checks if name exists
func exists(name: String) -> bool:
	return name in _entry


## Load model by name
func load_name(name: String) -> Object:
	if name not in _entry:
		print("[ModelLoader] Can't find %s" % name)
		return null
	
	var target = _entry[name]["file"][0]
	var scale = _entry[name]["scale"][0]
	
	print("[ModelLoader] Instantiating %s scale=%s" % [target, scale])
	
	# load & instantiate model
	var model = load(_base_format % target).instantiate()
	
	# scale
	model.scale = Vector3(scale, scale, scale)
	
	return model
