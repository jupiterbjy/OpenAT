class_name MapWeather
extends Node3D


@onready var _root: Node3D = $root

var _speed: float = 50.0
var _reset_height: float = 200.0
var _min_height: float = -200.0


func parse_json():
	
	if MapJsonLoader.current_loaded["weather"] == "NONE":
		return
	
	# load weather and add material
	var obj = ModelLoader.load_name(MapJsonLoader.current_loaded["weather"])
	TextureLoader.set_mat(obj, MapJsonLoader.current_loaded["weather"])
	
	_root.add_child(obj)


func _process(delta):
	_root.position.y -= delta * _speed
	if _root.position.y < _min_height:
		_root.position.y = _reset_height
