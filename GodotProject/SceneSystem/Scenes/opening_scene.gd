extends Node3D


# skybox(or cylinder) model
var _skybox = ["MSSKY", Vector3(0, 0, 0), Vector3(0, 0, 0)]

# skybox root
@onready var _skybox_root: Node3D = $skybox_root

# skybox rotation speed
var _skybox_rot_speed: float = -0.05

# static models to load
var _mapshow_list: Array[Array]= [
	# model name, position, rotation, optional texture name
	["MSEGYPT", Vector3(0, 0, 0), Vector3(0, 0, 0)],
	["MSFOREST", Vector3(0, 0, 0), Vector3(0, 0, 0)],
	["MSICE", Vector3(0, 0, 0), Vector3(0, 0, 0)],
	["MSSNOW", Vector3(0, 0, 0), Vector3(0, 0, 0)],
	
	# Yup! Pyramid is tree! Took a bit to figure it out until opening blender
	["MSTREE", Vector3(0, 0, 0), Vector3(0, 0, 0), "MSEGYPT"],
	["MSTUND", Vector3(0, 0, 0), Vector3(0, 0, 0)],
	["MSWATER", Vector3(0, 0, 0), Vector3(0, 0, 0), "MSFOREST"],
]

@onready var _tank_list: Array[Array] = [
	[$Tank_Easy, "TANKENEMY"],
	[$Tank_Normal, "TANKENEMY"],
	[$Tank_Hard, "TANKENEMY"],
	[$Tank_Player, "TANKPL1"],
	[$Tank_Player2, "TANKPL1"],
]

var _weather_list = [
	
]

var _plane_list = [
	
]

## builds object from array
## [model name, position vec3, (rad)rotation vec3, (optional) texture name]
func _load_obj(arr: Array):
	var obj = ModelLoader.load_name(arr[0])
	
	var tex = arr[3] if len(arr) == 4 else arr[0]
	TextureLoader.set_mat(obj, tex)
	
	obj.position = arr[1]
	
	if arr[2] != Vector3(0, 0, 0):
		obj.rotate_x(arr[2].x)
		obj.rotate_y(arr[2].y)
		obj.rotate_z(arr[2].z)

	return obj


func _load_mapshow():
	print("[opening_scene] Loading resources")
	_skybox_root.add_child(_load_obj(_skybox))
	
	for arr in _mapshow_list:
		add_child(_load_obj(arr))
	
	for arr in _tank_list:
		TextureLoader.set_mat(arr[0], arr[1])


# Called when the node enters the scene tree for the first time.
func _ready():
	_load_mapshow.call_deferred()


func _process(delta):
	_skybox_root.rotate_y(delta * _skybox_rot_speed)
