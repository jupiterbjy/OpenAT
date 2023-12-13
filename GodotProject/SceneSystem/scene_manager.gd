class_name SceneManager
extends Node3D


var _path_template: String = "res://SceneSystem/Scenes/%s.tscn"

var _scenes = [
	"opening_scene",
	"level_scene",
	"stage_editor",
]

enum {OPENING, LEVEL, EDITOR}

var _scene_cache: Dictionary = {}


func load_scene(scene_enum):
	# if there's current scene queue for drop
	if SceneSignals.current_scene:
		SceneSignals.current_scene.queue_free()
	
	# check cache for PackedScene - if not, load one
	if scene_enum not in _scene_cache:
		_scene_cache[scene_enum] = load(_path_template % _scenes[scene_enum])
	
	SceneSignals.current_scene = _scene_cache[scene_enum].instantiate()
	add_child(SceneSignals.current_scene )


func _ready():
	SceneSignals.request_scene.connect(load_scene)
