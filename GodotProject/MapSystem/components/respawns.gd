class_name MapRespawns
extends Node


var level: Level

var player_respawn: Vector2
var _unknown_respawns: Array[Vector2] = []
var enemy_respawns: Array[Vector2] = []

var player_ref: PlayerTank
var _player_scene: PackedScene = preload("res://TankSystem/tanks/tank_player.tscn")

var player_respawns: int = 3

var enemy_count: int = MapJsonLoader.current_loaded["enemy_count"]
var enemy_alive: int = 0
var allie_alive: int = 0

var spawn_sequence: String

var _next_gate_idx = 0

enum {NORTH, WEST, SOUTH, EAST}

@onready var parser: Parser = get_child(0)


func parse_json():
	var map_size: Array = MapJsonLoader.current_loaded["size"]
	var temp_arr: Array[Vector2] = []
	
	for position in MapJsonLoader.current_loaded["respawn"]:
		
		# coorindate for these are Y-inverted
		temp_arr.append(Vector2(position[1], map_size[1] - position[2] - 1))
	
	player_respawn = temp_arr[0]
	
	for idx in range(1, 4):
		_unknown_respawns.append(temp_arr[idx])
	
	for idx in range(4, 8):
		enemy_respawns.append(temp_arr[idx])


## returns enemy spawn position. Facing is fixed to south
func get_enemy_spawn() -> Vector2:
	var next_pos = enemy_respawns[_next_gate_idx]
	_next_gate_idx = (_next_gate_idx + 1) % 4
	
	return next_pos


## returns allie spawn position. this need to be random, but will spawn at player's spawn for now
func get_allie_spawn() -> Vector2:
	return player_respawn


func on_player_death():
 
	if player_respawns <= 0 and not level.is_demo:
		MapSignals.game_over.emit()
		return
	
	player_respawns -= 1
	
	UISignals.player_life_lost.emit()
	respawn_player()


func respawn_player():
	# allie_alive += 1
	
	player_ref = _player_scene.instantiate()
	
	add_child(player_ref)
	player_ref.post_ready_setup("", NORTH, player_respawn)
	player_ref.autonomous = get_parent().get_parent().is_demo
	player_ref.start()
	
	UISignals.player_health_ratio_changed.emit(1.0)
	# MapSignals.tank_spawned.emit(true, player_respawn)
	MapSignals.player_spawned.emit(player_ref)


# (_codes: String, level: Level, facing, start_pos)

func spawn_player():
	if player_ref:
		MapSignals.tank_destroyed.emit(true, player_respawn, 0)
		player_ref.queue_free()
	
	player_ref = _player_scene.instantiate()
	
	add_child(player_ref)
	player_ref.post_ready_setup("", NORTH, player_respawn)
	player_ref.start()
	
	UISignals.player_health_ratio_changed.emit(1.0)
	MapSignals.player_spawned.emit(player_ref)
	# MapSignals.tank_spawned.emit(true, player_respawn)


func _on_tank_death(is_allie: bool, pos: Vector2, score: int):
	if is_allie:
		allie_alive -= 1
	else:
		enemy_count -= 1
		enemy_alive -= 1
	
	# if secondary check fires, probably due to me not yet implementing turret and bunkers
	if enemy_count == 0 or (enemy_alive == 0 and not parser.current_string):
		MapSignals.game_victory.emit()
	
	elif enemy_alive == 0 and not get_tree().paused:
		$parser.skip_waits()


# this is VERY weird design choices, but I have no time to plan or anything rn
func _on_tank_spawn(is_allie: bool, pos: Vector2):
	if not is_allie:
		enemy_alive += 1
	else:
		allie_alive += 1


func _ready():
	level = get_parent().get_parent()
	MapSignals.player_destroyed.connect(on_player_death)
	MapSignals.tank_destroyed.connect(_on_tank_death)
	MapSignals.tank_spawned.connect(_on_tank_spawn)
	MapSignals.update_player_loadout.connect(spawn_player)


func start():
	spawn_player()
	$parser.start()
