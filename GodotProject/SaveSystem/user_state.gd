extends Node


signal user_state_loaded
signal user_state_saved

signal new_user_needed
signal new_user_created

var require_new_user:bool = false

var user_state_dir: String = "user://states/"
var user_state_path: String = "user://states/%s.json"
var user_names_cache: Dictionary = {}


var _default_state: Dictionary = {
	# UTC time of user creation.
	"created": 0,
	
	# last access epoch time - used to determine who played last time
	# updated on each save & load
	"last_access": 0,
	
	# user name
	"user_name": "Sorasaki Hina",
	
	# current open area & level
	"current_area": 1,
	"current_level": 0,
	
	# money
	"money": 0,
	
	# upgrades - range is 0 1 2 3
	"upgrades": [0, 0, 0, 0, 0],
	
	# unlocked weapon
	"weapons": [1, 0, 0, 0, 0, 0],
	
	# selected weapon index
	"selected_weapon_idx": 0,
	
	# score
	"score": 0,
}
var _state: Dictionary = _default_state.duplicate(true)


## property type hints
# var created: int
# var last_access: int
# var user_name: String
# var current_area: int
# var current_level: int
# var money: int
# var upgrades: Array[int]
# var weapons: Array[int]
# var selected_weapon_idx: int
# var score: int


# properties for easier access - not sure if tradeoff is fair enough for this
func _set(property: StringName, val) -> bool:
	if property in _state:
		_state[property] = val
		return true
	
	return false


func _get(property: StringName):
	return _state[property] if property in _state else null


## Update Dictionary somewhat like python's (a | b) - (a - b)
func _update_user_state(other: Dictionary):
	for key in other:
		if key not in _state:
			print("[UserState] Dropping key %s" % key)
			continue
		
		_state[key] = other[key]


## save state as json file. Uses current unix time as name.
func save_json():
	print("[UserState] Saving user state for %s" % _state["created"])
	
	# update time
	_state["last_access"] = int(Time.get_unix_time_from_system())
	
	# write file
	var file = FileAccess.open(
		user_state_path % _state["created"],
		FileAccess.WRITE
	)
	file.store_line(JSON.stringify(_state))
	
	user_state_saved.emit()


## load state from json file. Returns true if successful else false
func load_json(created_time: int) -> bool:
	Difficulty.difficulty = Difficulty.DIFF.NORMAL
	
	var file = FileAccess.open(
		user_state_path % created_time,
		FileAccess.READ_WRITE
	)
	
	if not file:
		return false
	
	# load
	var state: Dictionary = JSON.parse_string(file.get_as_text())
	
	# update access time
	_update_user_state(state)
	save_json()
	
	user_state_loaded.emit()
	return true


## Creates new user file with given name. If name's already taken, returns false
func create_new_user(user_name: String) -> bool:
	Difficulty.difficulty = Difficulty.DIFF.NORMAL
	
	user_name = user_name.strip_edges()
	
	if not is_name_usable(user_name):
		return false
	
	print("[UserState] Creating user %s" % user_name)
	
	_state = _default_state.duplicate(true)
	_state["user_name"] = user_name
	_state["created"] = int(Time.get_unix_time_from_system())
	
	save_json()
	update_cache()
	
	return true


## loads most recent user state. Returns true if successful else false
func _load_recent_user() -> bool:
	var state_dir = DirAccess.open(user_state_dir)
	
	# we have no user state dir, make one and return false
	if not state_dir:
		DirAccess.make_dir_absolute(user_state_dir)
		return false
	
	# start searching for json files
	var file_names: PackedStringArray = state_dir.get_files()
	
	# prep temporary variable for storing states & name
	var latest_state: Dictionary = _default_state.duplicate(true)
	var latest_file_name: String
	
	for file_name in file_names:
		
		# check for extention, hope no one save file as .JSON!
		if not file_name.ends_with(".json"):
			continue
		
		# load and check it's access time
		var file = FileAccess.open(user_state_dir + file_name, FileAccess.READ)
		var state: Dictionary = JSON.parse_string(file.get_as_text())
		
		# if it's more recent than current, update variables
		if latest_state["last_access"] < state["last_access"]:
			latest_file_name = file_name
			latest_state = state

	# if lastest state file name is empty we got nothing, probably no file.
	if not latest_file_name:
		return false
	
	# otherwise we got state we want, update access time
	_update_user_state(latest_state)
	save_json()
	
	return true


## read all user files again and fetch name & file name into cache.
func update_cache():
	
	# truncate dictionary
	user_names_cache.clear()
	
	var state_dir = DirAccess.open(user_state_dir)
	var file_names: PackedStringArray = state_dir.get_files()
	
	for file_name in file_names:
		var file =  FileAccess.open(user_state_dir + file_name, FileAccess.READ)
		var file_state: Dictionary = JSON.parse_string(file.get_as_text())
		
		user_names_cache[str(file_state["created"])] = file_state["user_name"]
	
	print("[UserState] Found %s states" % len(user_names_cache))


## Check if given user name is avaliable for new account.
func is_name_usable(user_name: String) -> bool:
	if user_name in user_names_cache.values():
		print("[UserState] User name %s already taken" % user_name)
		return false

	return true


## Deletes user. One should never delete current user.
func delete_user(user_key: int):

	print("[UserState] Deleting %s" % user_key)
	
	var state_dir: DirAccess = DirAccess.open(user_state_dir)
	state_dir.remove("%s.json" % user_key)
	
	update_cache()


## Startup action
func initialize():
	if not _load_recent_user():
		print("[UserState] No previous users, new user required")
		
		# using signal here so adding new 2nd, 3rd, etc users has same interface
		new_user_needed.emit()
		require_new_user = true


func _ready():
	initialize()
	update_cache()
