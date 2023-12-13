extends Node


## Base format for constructing json resource path
var _base_json_format: String = "res://Textures/jsons/%s.json"

## name of base texture info file
var _base_name: String = "texture"

## Base texture info file
var _base_json: Dictionary = {}

## name of override files
var _override_name: Array[String] = [
	"texture-cast",
	"texture-dung",
	"texture-egypt",
	"texture-fire",
	"texture-forest",
	"texture-grot",
	"texture-ice",
	"texture-sand",
	"texture-snow",
	"texture-tund",
]

## Dictionary containing texture info dictionary.
var _overrides_json: Dictionary = {}

## Current override textures
var _current_override = "texture-forest"

## Base format for constructing resource path
var _base_img_format: String = "res://Textures/%s"

## Dictionary containing created StandardMaterial 3D
var _cached_materials: Dictionary = {}

## Dictionary containing dictionary that contains created StandardMaterial 3D
var _cached_override_materials: Dictionary = {}


# load json files
func _ready():
	var file = FileAccess.open(_base_json_format % _base_name, FileAccess.READ)
	_base_json = JSON.parse_string(file.get_as_text())
	
	for name in _override_name:
		file = FileAccess.open(_base_json_format % name, FileAccess.READ)
		_overrides_json[name] = JSON.parse_string(file.get_as_text())


## Set current override
func set_override(key: String):
	_current_override = key


## get texture
func _get_tex(key: String) -> Texture2D:
	return load(_base_img_format % key)


## base function for getting material if already created, otherwise creating new one.
func _get_mat(key: String, entry_dict: Dictionary, cache_dict: Dictionary) -> StandardMaterial3D:
	
	# check if cached
	if key in cache_dict:
		print("[TextureLoader] Cache hit %s" % key)
		return cache_dict[key]
	
	print("[TextureLoader] Cache miss %s" % key)
	
	# need to create one, create new
	var mat: StandardMaterial3D = StandardMaterial3D.new()
	
	# search matching entry
	var entry: Dictionary = entry_dict[key]
	
	# setup material
	if entry["alpha"]:
		mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	
	elif entry["blend_add"]:
		mat.blend_mode = BaseMaterial3D.BLEND_MODE_ADD
	
	mat.albedo_texture = _get_tex(entry["file"])
	
	# cache
	cache_dict[key] = mat
	
	return mat


## Set Material to model by texture name
func set_mat(mesh: MeshInstance3D, key: String, override: bool = false):
	var mat: StandardMaterial3D
	
	# if override, search override texture & cache
	if override:
		mat = _get_mat(
			key, _overrides_json[_current_override], _cached_override_materials[_current_override]
		)
	else:
		mat = _get_mat(key, _base_json, _cached_materials)
	
	# set to model
	mesh.material_override = mat
