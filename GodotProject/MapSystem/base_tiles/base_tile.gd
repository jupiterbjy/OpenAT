class_name BaseTile
extends Node3D


var water: bool = false
var solid: bool = false

var pos: Vector2
var _model: Node3D
var _collider_prefab: PackedScene = preload(
	"res://MapSystem/base_tiles/base_collider.tscn"
)


func _setup_collisions(collision_areas: Array[Vector2], layer: int):
	for tile_pos in collision_areas:
		
		# instantiate collider & set layer
		var _collider: Area3D = _collider_prefab.instantiate()
		_collider.collision_mask = layer
		
		# add to scene & position it
		add_child(_collider)
		_collider.position = Vector3(-tile_pos.y, 0, -tile_pos.x)


func _parse_terr_arg(arg: String):
	# terr_arg: N, NW, NWF

	# F indicate no pass, even bullets
	if "F" in arg:
		water = true
		solid = true
	
	# W indicate no pass except bullets, water I guess?
	elif "W" in arg:
		water = true


func _parse_tile_arg(arg: String):
	# strip starting N
	arg = arg.lstrip("N")
	
	for ch in arg:
		match ch:
			"1":
				_model.rotate_y(-PI / 2)
			"2":
				_model.rotate_y(-PI)
			"3":
				_model.position.y += 0.165
			"4":
				_model.position.y += 0.33
			"5":
				_model.position.y += 0.665
			var unknown:
				print("[BaseTile] Unknown parameter %s for %s" % [unknown, pos])


## Sets up tile - return False if such model doesn't exist.
func setup_tile(
	tile_pos: Vector2,
	model_name: String,
	terr_arg: String = "",
	tile_arg: String = "",
	tex_name: String = "",
	override: String = "",
	collision_layer: int = 7,
) -> bool:
	if not tex_name:
		tex_name = model_name
	
	# setup model & check if null, if so return false
	_model = ModelLoader.load_name(model_name)
	if _model == null:
		return false
	
	# setup texture
	TextureLoader.set_mat(_model, tex_name, override)
	
	# move tile & adjust default rotation
	pos = tile_pos
	position.x = tile_pos.x
	position.z = tile_pos.y
	_model.rotate_y(PI)
	
	# add as child
	add_child(_model)

	# setup arguments
	_parse_terr_arg(terr_arg)
	_parse_tile_arg(tile_arg)
		
	# setup collision
	if solid:
		_setup_collisions(CollisionLoader.get_area(model_name), collision_layer)
	
	return true


## action on hit
func on_hit(damage: int, is_enemy: bool, is_electric: bool = false):
	# no action for base tile / terrain tiles
	pass
