class_name Level
extends Node3D


# subsystems
# @onready var header: MapHeader = $header
@onready var weather: MapWeather = $weather
@onready var items: MapItems = $center_offset/items
@onready var flags: MapFlags = $center_offset/flags
@onready var event_objs: MapEvents = $center_offset/event_objs
@onready var respawns: MapRespawns = $center_offset/respawns
@onready var walls: MapWalls = $center_offset/walls
@onready var terr: MapTerr = $center_offset/terr
@onready var terr2: MapTerr2 = $center_offset/terr2

@onready var aim_point: Sprite3D = $aim_point/aim_point

# demo mode - that automatic play in background of main menu
var is_demo: bool = false

# game mode
var game_type: String

# passable tiles combined of terr & wall
var passable_tiles: Array[Array]

## tanks location. first 2D arr is enemy counts in tile, second 2D arr is allie counts in tile
var tanks: Array[Array] = [
	[],
	[],
]


#signal item_taken(item_obj: BaseItem, by: BaseTank)
#
#signal tank_move(is_allie: bool, start: Vector2, end: Vector2)
#signal tank_destroyed(is_allie: bool, pos: Vector2)

func _on_tank_spawn(is_allie: bool, pos: Vector2):
	print("[Level] Tank spawned at %s [a: %s]" % [pos, is_allie])
	tanks[int(is_allie)][pos.y][pos.x] += 1


func _on_tank_death(is_allie: bool, pos: Vector2, _score: int):
	print("[Level] Tank destroyed at %s [a: %s]" % [pos, is_allie])
	tanks[int(is_allie)][pos.y][pos.x] -= 1


func _on_tank_move(is_allie: bool, start: Vector2, end: Vector2):
	# print("[Level] Tank move %s to %s [a: %s]" % [start, end, is_allie])
	var idx = int(is_allie)
	
	tanks[idx][start.y][start.x] -= 1
	tanks[idx][end.y][end.x] += 1


func init_tank_arr():
	
	for row in range(MapJsonLoader.current_loaded["size"][1]):
		var temp_arr_0 = []
		var temp_arr_1 = []
		
		for col in range(MapJsonLoader.current_loaded["size"][0]):
			temp_arr_0.append(0)
			temp_arr_1.append(0)
		
		tanks[0].append(temp_arr_0)
		tanks[1].append(temp_arr_1)


func init_passable_tiles():
	# no need for deepcopy, terr won't use that internally
	passable_tiles = terr.passable_tiles
	
	for row in range(MapJsonLoader.current_loaded["size"][1]):
		for col in range(MapJsonLoader.current_loaded["size"][0]):
			if walls.clustors[row][col]:
				passable_tiles[row][col] = false
	
	if "F" in game_type:
		passable_tiles[flags.tile.tile_pos.y][flags.tile.tile_pos.x] = false


func _on_walls_wall_cluster_destroyed(cluster: BaseWallCluster):
	passable_tiles[cluster.tile_pos.y][cluster.tile_pos.x] = true
	walls.on_cluster_destroyed(cluster)

func _on_walls_wall_cluster_regened(cluster: BaseWallCluster):
	passable_tiles[cluster.tile_pos.y][cluster.tile_pos.x] = false
	walls.on_cluster_regen(cluster)


## enter demo mode
func enable_demo_mode():
	print("[Level] Enabling demo mode")
	
	if is_demo:
		print("[Level] Already in demo mode, ignoring")
		return
	
	is_demo = true
	aim_point.hide()
	
	VolumeManager.mute_ingame_sound()
	
	respawns.player_ref.enter_demo_mode()
	CamSignals.request_cam.emit(CamManager.FOLLOW)


## disable demo mode - used upon resume
func disable_demo_mode():
	print("[Level] Disabling demo mode")
	
	if not is_demo:
		print("[Level] Already not in demo mode, ignoring")
		return
		
	is_demo = false
	aim_point.show()
	
	VolumeManager.unmute_ingame_sound()
	
	respawns.player_ref.exit_demo_mode()
	CamSignals.request_cam.emit(CamManager.INGAME)


func game_over():
	if is_demo:
		return
	
	MapSignals.game_pause.emit()
	print("[Level] Game over!")
	
	CamSignals.request_cam.emit(CamManager.INGAME_PAUSED)
	UISignals.request_overlay.emit(UIEnum.DIA_LOSE1)
	$lose_timer.start(5)


func game_win():
	if is_demo:
		return
	
	MapSignals.game_pause.emit()
	print("[Level] Victory!")
	
	# add credit & scores
	UserState.score += ScoreSystem.score_tank + ScoreSystem.score_item
	UserState.money += MapJsonLoader.current_loaded["cost"]

	CamSignals.request_cam.emit(CamManager.INGAME_PAUSED)
	UISignals.request_overlay.emit(UIEnum.DIA_WIN)
	$win_timer.start(5)
		
	# prevent progression if it isn't current progression area or if it's final stage.
	if UserState.current_area != MapJsonLoader.current_area or UserState.current_area == 13:
		UserState.save_json()
		return
	
	# check if this was cleared level or not (separating to keep < 80)
	if UserState.current_level != MapJsonLoader.current_level:
		UserState.save_json()
		return
	
	advance_progress()
	UserState.save_json()


## Progress level or area
func advance_progress():
	print("[ui_map_select] Updating progress")

	# if there's more next map assigned, progress level
	if MapJsonLoader.current_loaded["next_map"]:
		UserState.current_level += 1
		return
	
	# progress area & reset level to 0
	UserState.current_area += 1
	UserState.current_level = 0


func _on_lose_timer_timeout():
	UISignals.request_ui.emit(UIEnum.GAME_OVER)



func _on_win_timer_timeout():
	UISignals.request_ui.emit(UIEnum.SCORE)


func setup():
	game_type = MapJsonLoader.current_loaded["game_type"]
	
	var subsystems: Array = [
		weather, items, event_objs, respawns, walls, terr, terr2
	]
	
	# only add flag if gamemode is Base defense
	if "F" in game_type:
		subsystems.append(flags)

	# init subsystems
	for subsystem in subsystems:
		subsystem.parse_json()
	
	# setup tile accesibility cache
	init_passable_tiles()
	init_tank_arr()
	
	respawns.start()
	
	# check if this should be running as demo mode
	if UISignals.current_ui_enum != UIEnum.BRIEFING and UISignals.current_ui_enum != UIEnum.TUTORIAL:
		enable_demo_mode()


func on_pause():
	if not is_demo:
		aim_point.hide()


func on_unpause():
	if not is_demo:
		aim_point.show()


# wait until player is ready
func enter_demo_immediate():
	$init_delay.start(1)


func _ready():
	setup.call_deferred()
	
	ScoreSystem.reset_score()
	
	MapSignals.tank_destroyed.connect(_on_tank_death)
	MapSignals.tank_spawned.connect(_on_tank_spawn)
	MapSignals.tank_moved.connect(_on_tank_move)
	MapSignals.wall_cluster_destroyed.connect(_on_walls_wall_cluster_destroyed)
	MapSignals.wall_cluster_regened.connect(_on_walls_wall_cluster_regened)
	MapSignals.game_victory.connect(game_win)
	MapSignals.game_over.connect(game_over)
	MapSignals.enter_demo.connect(enter_demo_immediate)
	
	MapSignals.game_pause.connect(on_pause)
	MapSignals.game_unpause.connect(on_unpause)


func _on_init_delay_timeout():
	enable_demo_mode()
	get_tree().paused = false
