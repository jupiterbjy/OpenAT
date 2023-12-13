extends Node


signal global_state_loaded
signal global_state_saved


## global state save file in user path
var _global_state_path: String = "user://global_state.json"


## Template state when generating default
var _default_state: Dictionary = {
	# volume -1.0 ~ 1.0
	"sound_vol": 0,
	"music_vol": 0,
	
	# language - wont be implemented for far into development
	"language": 0,
	
	# leaderboards - this better be sorted upon insertion
	"leaderboards": [
		["Sorasaki Hina", 219219],
	],
}
var _state: Dictionary = _default_state


# type hints for below property accesses
# var sound_vol: int
# var music_vol: int
# var language: int
# var leaderboards: Array[Array]


# properties for easier access
func _set(property: StringName, val) -> bool:
	if property in _state:
		_state[property] = val
		return true
	
	return false


func _get(property: StringName):
	return _state[property] if property in _state else null


## save global state to file
func save_json():
	print("[GlobalState] Saving state")
	
	var file = FileAccess.open(_global_state_path, FileAccess.WRITE)
	file.store_line(JSON.stringify(_state))
	
	global_state_saved.emit()


## load global state from file - returns true if successful else false
func load_json() -> bool:
	print("[GlobalState] Loading state")
	
	# load file
	var file = FileAccess.open(_global_state_path, FileAccess.READ)
	
	if not file:
		return false
	
	var loaded: Dictionary = JSON.parse_string(file.get_as_text())
	
	# update key by key in case of newer dictionary entries in template
	for key in loaded:
		_state[key] = loaded[key]
	
	# emit signal and return
	global_state_loaded.emit()
	return true


## initializiation on game start - need to be called by main scene
func initialize():
	if not load_json():
		print("[GlobalState] No state found, creating new")
		save_json()


func _ready():
	initialize()
