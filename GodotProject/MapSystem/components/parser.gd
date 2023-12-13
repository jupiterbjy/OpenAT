class_name Parser
extends Node


@onready var _spawn_timer: Timer = $spawn_timer
@onready var _parent = get_parent()


var _level: Level
var _template = "res://TankEntities/%s.tscn"
var _last_code: String
var _spawn_count: int = MapJsonLoader.current_loaded["enemy_count"]

var _enemies_until_next_item: int = 3 

var current_string: String
var stack: String = ""

enum {NORTH, WEST, SOUTH, EAST}


func parse_boss_tank(codes: String) -> TankStats.TYPE:

	if "K" in codes:
		return TankStats.TYPE.KB

	elif "L" in codes:
		return TankStats.TYPE.KB

	elif "S" in codes:
		return TankStats.TYPE.KB
	
	return TankStats.TYPE.EASY


func load_tank(codes: String) -> PackedScene:
	var _type: TankStats.TYPE = parse_boss_tank(codes) if "B" in codes else int(codes[0])
	return TankEntries.get_tank(_type)


func spawn_tank(codes: String):
	_spawn_count -= 1
		
	# my fault, this actually count down as tank spawns, not when dead
	UISignals.enemy_destroyed.emit()
	
	var tank_scene = load_tank(codes)
	var tank: BaseTank = tank_scene.instantiate()
	
	_parent.add_child(tank)
	
	if codes[0] != "0":
		if "B" not in codes and not _enemies_until_next_item:
			_enemies_until_next_item = 3
			tank.is_item_drop = true
		
		elif "B" not in codes:
			_enemies_until_next_item -= 1
		
		tank.post_ready_setup(codes, SOUTH, _parent.get_enemy_spawn())
		tank.start()
		return
	
	# check if we hit allie limit
	if get_owner().allie_alive >= 2:
		return
	
	tank.post_ready_setup(codes, NORTH, _parent.get_allie_spawn())
	get_owner().allie_alive += 1
	get_owner().enemy_count -= 1
	# get_owner().enemy_alive += 1
	tank.start()
	
	# show ui if it's not in demo
	if not _level.is_demo:
		UISignals.request_overlay.emit(UIEnum.DIA_ALLIE)


func _process_and_wait(wait_time: float):
	print("[Parser] Processing code '%s' [stack: %s]" % [current_string[0], stack])
	_spawn_timer.start(wait_time)
	
	if stack:
		print("[Parser] Spawning tank with %s" % stack)
		spawn_tank(stack)
		stack = ""


## if there's no more to parse, returns false, otherwise true.
## Actual parsing of attribute happens on TankBase.
func parse_next():
	if not current_string or not _spawn_count:
		print("[Parser] Spawn stop, remaining string: [%s]" % current_string)
		
		if not _level.is_demo:
			return
		
		# if demo mode is on, reset string, infinite mode!
		current_string = MapJsonLoader.current_loaded["spawn_sequence"]
		_spawn_count = MapJsonLoader.current_loaded["enemy_count"]
		stack = ""
		skip_waits.call_deferred()
		return
	
	var parsing_tank = true
	
	while parsing_tank:
		match current_string[0]:
			" ", "\n", "\t":
				parsing_tank = false
				_process_and_wait(1.0)
			"P":
				parsing_tank = false
				_process_and_wait(5.0)
			"D":
				parsing_tank = false
				_process_and_wait(30.0)
			_:
				print("[Parser] Stacking code '%s' [stack: %s]" % [current_string[0], stack])
				stack += current_string[0]
		
		_last_code = current_string[0]
		current_string = current_string.erase(0)


func _on_spawn_timer_timeout():
	parse_next()


func start():
	_level = get_parent().level
	current_string = MapJsonLoader.current_loaded["spawn_sequence"]
	_spawn_timer.start(0.1)


func skip_waits():
	print("[Parser] Skipping waits")
	
	_spawn_timer.stop()
	current_string = current_string.lstrip(" \nPD")
	
	_on_spawn_timer_timeout()


func _unhandled_input(event):
	
	# we need to skip long waits for faster debugging. Stop timer and run manually
	if event.is_action_pressed("skip_timer_debug"):
		skip_waits()
