class_name BaseWallCluster
extends Node3D


signal wall_destroyed(wall_position)


var _wall_debris: Node3D
var _gizmo
var _target_area: Area3D


enum CORNER {TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT}

enum WALL {BRICK, STONE, BRICK_TGT}

static var _wall_scenes: Array[PackedScene] = [
	preload("res://WallSystem/brick_wall.tscn"),
	preload("res://WallSystem/stone_wall.tscn"),
]

static var _types: Array[String] = [
	"#420",
	"%",
	"&579"
]


var tile_pos: Vector2
var walls: Array[BaseWall] = []
var wall_count: int = 4

## If true, enemy tanks will pathfind to this and attack it.
var is_target: bool = false
var cluster_type: WALL


## Determine tile cluster's unit
func _parse_global_type(codes: String):
	
	for code in codes:
		# short enough, better not use loops
		if code in _types[WALL.BRICK]:
			return WALL.BRICK
		
		if code in _types[WALL.STONE]:
			return WALL.STONE
		
		if code in _types[WALL.BRICK_TGT]:
			# this is target wall, mark as target and replace gizmo
			is_target = true
			
			$cluster_gizmo.queue_free()
			_gizmo = load("res://Commons/DebugGizmos/tgt_cluster_gizmo.tscn").instantiate()
			add_child(_gizmo)
			
			_target_area = load("res://WallSystem/target_hitbox.tscn").instantiate()
			add_child(_target_area)
			return WALL.BRICK
	
	print("[BaseWallCluster] Could not determine type of " + codes)
	# return nothing this case, we want this be raised


func _setup_debris():
	if _wall_debris != null:
		return
		
	_wall_debris = ModelLoader.load_name("BIGCRASH")
	add_child(_wall_debris)
	
	var texture_type: String = "WALLSTONE" if cluster_type == WALL.STONE else "WALLB2"
	TextureLoader.set_mat(
		_wall_debris,
		texture_type,
		MapJsonLoader.current_loaded["texture_override"]
	)


## Parse 4 letter string, witch top left, top right, bottom left, bottom right order
func setup(codes: String, pos: Vector2, wall_map: Dictionary):
	# find out cluster type
	cluster_type = _parse_global_type(codes)
	
	# record position and move
	tile_pos = pos
	position = Vector3(tile_pos.x, 0, tile_pos.y)
	
	# parse each letters
	for section in [CORNER.TOP_LEFT, CORNER.TOP_RIGHT, CORNER.BOTTOM_LEFT, CORNER.BOTTOM_RIGHT]:
		var code = codes[section]
		
		if code == " ":
			walls.append(null)
			wall_count -= 1
			continue
		
		# create wall
		walls.append(_wall_scenes[cluster_type].instantiate())
		walls[-1].setup(code, section, tile_pos, wall_map)
		add_child(walls[-1])


func _ready():
	if _gizmo == null:
		_gizmo = $cluster_gizmo


## Run adjacent wall reference updates to child walls
func setup_adj(wall_map: Dictionary):
	for wall in walls:
		if wall:
			wall.setup_adj(wall_map)


## Remove all remaining walls
func preemtive_destroy():
	for wall in walls:
		if wall:
			wall.damage(4, true)


func _on_wall_destroyed(wall_position: CORNER):
	_setup_debris()
	walls[wall_position] = null
	wall_count -= 1
	
	if not wall_count:
		_wall_debris.queue_free()
		_gizmo.queue_free()
		MapSignals.wall_cluster_destroyed.emit(self)
		
		if _target_area:
			_target_area.queue_free()
		
		return

	if wall_count < 2:
		preemtive_destroy.call_deferred()
