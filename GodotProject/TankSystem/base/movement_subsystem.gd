class_name MovementSubsystem
extends Node


enum TYPE {ALLIE, ENEMY, BOSS}
var _tank_type

static var is_the_world = false


var _level: Level = SceneSignals.current_scene.get_child(0)
var _move_duration: float
var _turn_duration: float

enum FACING {NORTH, WEST, SOUTH, EAST}
var _current_facing = FACING.SOUTH

var in_movement: bool = false
var movement_queue: Array[Vector2]

@onready var _pathfinder: PathfindingSubSystem = $pathfinding_subsystem

@onready var _root: Node3D = get_parent()
var _model_root: Node3D

@onready var _timer: Timer = $move_cooltime
@onready var _bfs_cooltime: Timer = $bfs_cooltime

var current_pos: Vector2


func post_ready_setup(facing: FACING, type):
	_move_duration = get_owner().move_duration
	
	if type != TYPE.ALLIE:
		_move_duration *= Difficulty.multiplier[Difficulty.difficulty]
	
	_turn_duration = _move_duration / 2
	_current_facing = facing
	
	_tank_type = type
	
	# these can't use onready due to timing
	current_pos = Vector2(_root.position.x, _root.position.z)
	_model_root = _root.model_root


## 'Forward' Movement offset you can just add. Order is N-W-S-E
static var _forward_map_3d = [
	Vector3(0, 0, -1),
	Vector3(-1, 0, 0),
	Vector3(0, 0, 1),
	Vector3(1, 0, 0),
]

static var _forward_map = [
	Vector2(0, -1),
	Vector2(-1, 0),
	Vector2(0, 1),
	Vector2(1, 0),
]


func _offset_to_facing(start_: Vector2, end: Vector2):
	match end - start_:
		Vector2(0, -1):
			return FACING.NORTH
		Vector2(-1, 0):
			return FACING.WEST
		Vector2(0, 1):
			return FACING.SOUTH
		Vector2(1, 0):
			return FACING.EAST


var blocking_torrelance = 1
var _current_block_count = 0


## check if forward position is blocked
func is_blocking(target_pos: Vector2) -> bool:
	
	# most of time it's wall
	if not _level.passable_tiles[target_pos.y][target_pos.x]:
		return true
	
	# if is allie tank and enemy is in tile return false
	if _tank_type == TYPE.ALLIE and _level.tanks[0][target_pos.y][target_pos.x] > 0:
		return true
	
	# allie can't pass thru each other while enemy can, unfair!
	if _level.tanks[1][target_pos.y][target_pos.x] > 0:
		return true
	
	return false


func forward() -> bool:
	var tgt_pos = current_pos + _forward_map[_current_facing]
	
	if is_blocking(tgt_pos):
		# if remaining queue is 1, we're already looking at target
		# disabling this to encourage more movement
		# if len(movement_queue) == 1:
		# 	return false
		
		# otherwise we met other obstacles
		_current_block_count += 1
		
		# find new path
		if _current_block_count > blocking_torrelance:
			select_target({movement_queue[-1]: null})
		
		return false
	
	_current_block_count = 0
	in_movement = true

	# TODO: add raycast check
	var tween = create_tween()
	tween.set_parallel()
	
	# tween to new forward position & set timer
	var target_pos: Vector3 = round(_root.position + _forward_map_3d[_current_facing])
	
	# Detup tween and run. To prevent drift during lag, add a callback
	tween.tween_property(_root, "position", target_pos, _move_duration)
	tween.tween_callback(_root.set_position.bind(target_pos)).set_delay(_move_duration)

	# spawn trail
	MapSignals.spawn_trail.emit(current_pos, 1, _current_facing)
	tween.tween_callback(
		trail_signal_wrapper.bind(current_pos, 1, _current_facing)
	).set_delay(_move_duration / 2)
	
	tween.play()
	_timer.start(_move_duration)
	
	MapSignals.tank_moved.emit(int(_tank_type == TYPE.ALLIE), current_pos, tgt_pos)
	
	current_pos = tgt_pos
	return true


## Wrapping this because we can't use bind on emit
func trail_signal_wrapper(pos: Vector2, action, facing):
	MapSignals.spawn_trail.emit(pos + _forward_map[_current_facing] * 0.5, action, facing)


## Turn to target facing
func turn(tgt_facing: int):
	in_movement = true
	
	# calculate difference on shorter side
	var facing_diff = tgt_facing - _current_facing
	if facing_diff == -3:
		facing_diff += 4
	elif facing_diff == 3:
		facing_diff -= 4
	
	var diff = facing_diff * PI / 2
	
	# update facing
	_current_facing = tgt_facing
	
	var tween = create_tween()
	tween.set_parallel()
	
	# tween to new rotation & set timer
	var obj_rotation = Vector3(0, _model_root.rotation.y + diff, 0)
	
	# Setup tween and run. To prevent drift during lag, add a callback
	tween.tween_property(_model_root, "rotation", obj_rotation, _turn_duration)
	tween.tween_callback(_model_root.set_rotation.bind(obj_rotation)).set_delay(_turn_duration)
	tween.play()
	
	MapSignals.spawn_trail.emit(current_pos, 0, _current_facing)
	
	_timer.start(_turn_duration)


func _on_move_cooltime_timeout():
	in_movement = false
	
	if not _root.autonomous:
		return
	
	if is_the_world:
		_timer.start(1.0)
		return
	
	if movement_queue:
		move_next()
	else:
		if not select_target():
			move_aimlessly()


## checks queue and executes next required movement.
func move_next():
	# if in move ignore, will be called back by timer.
	if in_movement:
		return
	
	# get facing we need to take
	var target_facing = _offset_to_facing(current_pos, movement_queue[-1])
	
	# if facing is not same, we need to turn
	if target_facing != _current_facing:
		turn(target_facing)
		return
	
	# else we can try moving
	if forward():
		movement_queue.pop_back()
	else:
		# failed to move, reset timer and try again
		_timer.start(0.5)


var _in_bfs_cooldown = false	


func _on_bfs_cooltime_timeout():
	_in_bfs_cooldown = false
	
	select_target()


func select_target(ignore: Dictionary = {}):
	_current_block_count = 0
	
	if _in_bfs_cooldown:
		return false
	
	movement_queue = _pathfinder.bfs(current_pos, _tank_type, ignore)
	
	if movement_queue:
#		print(
#			"[MovementSubsystem] Found path to %s with length %s" % 
#			[movement_queue[0], len(movement_queue)]
#		)
		move_next()
		return true
	
	# if nothing to do then either side won
	# print("[MovementSubsystem] Queue empty")
	_bfs_cooltime.start(2)
	_in_bfs_cooldown = true
	
	return false


## Move straight until hitting something
func move_aimlessly():
	if not forward():
		turn((_current_facing + randi_range(1, 3)) % 4)


func start():
	_timer.start(0.1)
