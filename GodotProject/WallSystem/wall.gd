class_name BaseWall
extends Node3D


static var path_template = "res://Models/Custom/walls/%s.glb"


## Connection to each sides
enum MODEL {FULL, THREE, TWO, CORNER, ONE, NONE}
static var wall_types = [
	load(path_template % "wall_full_connect"),
	load(path_template % "wall_triple_connect"),
	load(path_template % "wall_straight_connect"),
	load(path_template % "wall_corner"),
	load(path_template % "wall_single_connect"),
	load(path_template % "wall_solo"),
]

static var smoke_scene = load("res://EffectSystem/wall_explode.tscn")

# global wall positioning system!
var wall_pos: Vector2

enum CORNER {TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT}
var _section: CORNER

# wall type code just for checking if wall's connecting to same type or not.
# 0 is basetile, 1 is brick wall, 2 is stone wall.
var wall_type = 0

var _current_wall = null
var health = 0


## adjacent walls in order of top, left, bottom, right
## injected by wall creation manager
var adj_tiles: Array[BaseWall] = [null, null, null, null]
enum ADJ {TOP, LEFT, BOTTOM, RIGHT}


## Gets active state of surrounding walls
func get_adjacent_wall_state() -> Array[bool]:
	
	var arr: Array[bool] = []
	
	for side in [ADJ.TOP, ADJ.LEFT, ADJ.BOTTOM, ADJ.RIGHT]:
		arr.append(adj_tiles[side] != null and adj_tiles[side].wall_type == wall_type)
	
	return arr


## Load wall model. Facing order is clockwise.
func load_model(type, facing: int):
	if _current_wall:
		_current_wall.queue_free()
	
	_current_wall = wall_types[type].instantiate()
	add_child(_current_wall)
	
	_current_wall.rotate_y(-facing * PI / 2 + PI)


## Base function for setting texture
func _set_texture_base(obj, texture_name: String):
	# one better not call while there's no wall model
	TextureLoader.set_mat(
		obj,
		texture_name,
		MapJsonLoader.current_loaded["texture_override"]
	)


## Abstract method for setting texture
func set_texture():
	pass


## Set wall to correct type
func update_model():
	var type = MODEL.FULL
	var facing = 0
	
	# A messy list of match checks - hope match is implemented correctly and not syntax sugar..
	match get_adjacent_wall_state():
		[false, false, false, false]:
			type = MODEL.NONE
		
		[true, false, false, false]:
			type = MODEL.ONE
			facing = 3
		
		[false, true, false, false]:
			type = MODEL.ONE
			facing = 2
		
		[false, false, true, false]:
			type = MODEL.ONE
			facing = 1
		
		[false, false, false, true]:
			type = MODEL.ONE
		
		[true, false, true, false]:
			type = MODEL.TWO
			facing = 1
		
		[false, true, false, true]:
			type = MODEL.TWO
		
		[true, true, false, false]:
			type = MODEL.CORNER
			facing = 3
		
		[false, true, true, false]:
			type = MODEL.CORNER
			facing = 2
		
		[false, false, true, true]:
			type = MODEL.CORNER
			facing = 1
		
		[true, false, false, true]:
			type = MODEL.CORNER
		
		[true, true, true, false]:
			type = MODEL.THREE
			facing = 2
		
		[false, true, true, true]:
			type = MODEL.THREE
			facing = 1
		
		[true, false, true, true]:
			type = MODEL.THREE
		
		[true, true, false, true]:
			type = MODEL.THREE
			facing = 3
		
		[true, true, true, true]:
			pass
	
	load_model(type, facing)
	set_texture()


func on_destroy():
	print("[BaseWall] Wall destroyed")
	
	# destroy model
	_current_wall.queue_free()
	$collision.queue_free()
	
	# emit signal
	get_parent().wall_destroyed.emit(_section)
	
	# notify other tiles
	for side in [ADJ.TOP, ADJ.LEFT, ADJ.BOTTOM, ADJ.RIGHT]:
		
		if adj_tiles[side]:
			
			# if adjacent tile exists, drop reference & trigger update
			adj_tiles[side].adj_tiles[(side + 2) % 4] = null
			adj_tiles[side].update_model()

	# instanciate crash model
	_current_wall = ModelLoader.load_name("CRASH")
	add_child(_current_wall)
	set_texture()
	
	# start animation
	var anim_player: AnimationPlayer = _current_wall.get_child(1)
	anim_player.play(anim_player.get_animation_list()[-1], -1, 0.5)
	anim_player.animation_finished.connect(_on_destroy_animation_done)
	
	# spawn smoke
	add_child(smoke_scene.instantiate())

func _on_destroy_animation_done(_anim_name):
	queue_free()


## Translate facing sides to Vector2 offset
func _side_to_offset(side) -> Vector2:
	
	match side:
		ADJ.TOP:
			return Vector2(0, -1)
			
		ADJ.LEFT:
			return Vector2(-1, 0)
			
		ADJ.BOTTOM:
			return Vector2(0, 1)
			
		ADJ.RIGHT:
			return Vector2(1, 0)
	
	# This better not run at all
	print("[BaseWall] Cannot determine side %s" % side)
	return Vector2()


## Translate section to Vector2 offset
func _section_to_offset(section) -> Vector2:
	match section:
		CORNER.TOP_LEFT:
			return Vector2(0, 0)
			
		CORNER.TOP_RIGHT:
			return Vector2(1, 0)
			
		CORNER.BOTTOM_LEFT:
			return Vector2(0, 1)
			
		CORNER.BOTTOM_RIGHT:
			return Vector2(1, 1)
	
	print("[BaseWall] Cannot determine section %s" % section)
	return Vector2()


## Setup process method
func setup(code: String, section, parent_pos: Vector2, wall_map: Dictionary):
	_section = section
	var offset: Vector2 = _section_to_offset(section)
	
	# calculate double resolution tilemap cooridnate for this wall
	wall_pos = parent_pos * 2 + offset
	
	var relative_pos = offset * 0.5 + Vector2(-0.25, -0.25)
	
	# move tile
	position = Vector3(relative_pos.x, 0, relative_pos.y)
	
	# record entry
	wall_map[wall_pos] = self


## Setup adjacent tiles by referring wall map
func setup_adj(wall_map: Dictionary):
	for side in [ADJ.TOP, ADJ.LEFT, ADJ.BOTTOM, ADJ.RIGHT]:
		
		var side_coordinate = _side_to_offset(side) + wall_pos
		
		if side_coordinate in wall_map:
			adj_tiles[side] = wall_map[side_coordinate]
	
	# update model
	update_model()


## Damage action - called by bullet side.
func damage(amount: int, is_electric=false):
	health -= amount
	
	if health < 1:
		on_destroy()
	else:
		set_texture()
