extends Node


## Base format for constructing json resource path
var _base_json_format: String = "res://Textures/jsons/%s.json"

## name of base texture info file
var _base_name: String = "texture"

## Base texture info file
var _base_json: Dictionary = {}

## name of override files
var _override_names: Array[String] = [
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

## Base format for constructing resource path
var _base_img_format: String = "res://Textures/Raw/%s"

## Dictionary containing created StandardMaterial 3D
var _cached_materials: Dictionary = {}

## Dictionary containing dictionary that contains created StandardMaterial 3D
var _cached_override_materials: Dictionary = {}


# load json files
func _ready():
	var file = FileAccess.open(_base_json_format % _base_name, FileAccess.READ)
	_base_json = JSON.parse_string(file.get_as_text())
	
	for override_name in _override_names:
		file = FileAccess.open(_base_json_format % override_name, FileAccess.READ)
		_overrides_json[override_name] = JSON.parse_string(file.get_as_text())
		
		# create cache dict for each materials
		_cached_override_materials[override_name] = {}


## get texture
func _get_tex(key: String) -> Texture2D:
	# godot's .import files are saved in lowercases only
	return load(_base_img_format % key)


## Base function of _get_mat for reuse
func _base_get_mat(key: String, entry_dict: Dictionary, mat: StandardMaterial3D):
	var entry: Dictionary = entry_dict[key]
	
	# turn off shading
	mat.shading_mode = mat.SHADING_MODE_UNSHADED
	
	# Set alpha
	if entry["alpha"]:
		mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	
	# Set add blend mode instead of alpha
	elif entry["blend_add"]:
		mat.blend_mode = BaseMaterial3D.BLEND_MODE_ADD
		mat.cull_mode = mat.CULL_DISABLED
	
	mat.albedo_texture = _get_tex(entry["file"])
	
	return mat


## base function for getting material if already created, otherwise creating new one.
func _get_mat(key: String, entry_dict: Dictionary, cache_dict: Dictionary) -> StandardMaterial3D:
	
	# check if cached
	if key in cache_dict:
		# print("[TextureLoader] Cache hit %s" % key)
		return cache_dict[key]
	
	if key not in entry_dict:
		print("[TextureLoader] No entry named %s" % key)
	
	print("[TextureLoader] Cache miss %s" % key)
	
	# create new
	var mat: StandardMaterial3D = _base_get_mat(key, entry_dict, StandardMaterial3D.new())
	
	# cache
	cache_dict[key] = mat
	
	return mat


## Set Material to model by texture name
func set_mat(obj: Node3D, key: String, override: String = "", unique=false):
	var mesh: MeshInstance3D = obj.get_child(0)
	var mat: StandardMaterial3D
	
	# if override, search override texture & cache
	if override:
		mat = _get_mat(
			key, _overrides_json[override], _cached_override_materials[override]
		)
	else:
		mat = _get_mat(key, _base_json, _cached_materials)
	
	if unique:
		mat = mat.duplicate()
	
	# set to model
	mesh.material_override = mat


var _fading_mat: StandardMaterial3D = preload("res://Textures/fading_mat.tres")


## Set model's Material to distance fading one for use in opening scene.
## This is not cached unlike set_mat.
func set_fading_mat(obj: Node3D, key: String):
	var mat: StandardMaterial3D = _base_get_mat(key, _base_json, _fading_mat.duplicate())
	var mesh: MeshInstance3D = obj.get_child(0)
	
	mesh.material_override = mat
