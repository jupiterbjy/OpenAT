extends Node


var maps: Array


var _template_path: String = "res://MapSystem/jsons/"


var current_loaded: Dictionary = {}
var current_area: int
var current_level: int


## load maps.json
func _load_maps():
	var json_content = FileAccess.open(
		"res://MapSystem/jsons/maps.json",
		FileAccess.READ
	).get_as_text()

	maps = JSON.parse_string(json_content)["areas"]


## returns level info written in maps.json
func get_level_info(area_id: int, level_id: int) -> Dictionary:
	return maps[area_id - 1]["level"][level_id]


## Load level json file and return it. This intentionally does not cache results
func get_level_data(area_id: int, level_id: int) -> Dictionary:
	var json_path = get_level_info(area_id, level_id)["file"]
	
	var level_data: Dictionary = JSON.parse_string(
		FileAccess.open(
			_template_path + json_path,
			FileAccess.READ,
		).get_as_text()
	)

	return level_data


## set map as loaded - just a wrapper for get_level_data.
func load_level_data(area_id: int, level_id: int) -> Dictionary:
	current_area = area_id
	current_level = level_id
	
	current_loaded = get_level_data(area_id, level_id)
	return current_loaded


func _ready():
	_load_maps()
