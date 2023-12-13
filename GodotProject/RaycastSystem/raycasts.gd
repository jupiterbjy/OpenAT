extends Node3D


# cache camera & viewport
@onready var _viewport = get_viewport()
@onready var _cam = _viewport.get_camera_3d()
@onready var _world_3d = get_world_3d()


var _layer_translation: Array[int] = [
	0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384
]

## Layer bits alias for accessing by layer name
var layers = {
	"TileTranslation": _layer_translation[3],
	"MouseTranslation": _layer_translation[4],
	"Healthed": _layer_translation[5],
	"Enemy": _layer_translation[6],
	"Allie": _layer_translation[7],
	"Terrain": _layer_translation[8],
	"Projectile": _layer_translation[9],
	"WallTarget": _layer_translation[10],
	"Item": _layer_translation[11],
	"Wall": _layer_translation[12],
	# "Neutral": _layer_translation[13],
	"Base": _layer_translation[14],
}


## Returns combined layer of given string array layer names
func get_combined_layers(layer_names: Array[String]) -> int:
	var combined: int = 0
	
	for layer_name in layer_names:
		combined = combined | layers[layer_name]
	
	return combined


## frequently used projectile's target layers combinations
var projectile_mask = layers["Healthed"] | layers["Terrain"] | layers["Projectile"] | layers["Wall"]

## Mask for testing if enemy tank in line-of-sight
var enemy_target_mask = layers["Allie"] | layers["WallTarget"] | layers["Terrain"]

## Mask for testing if allie tank in  line-of-sight
var allie_target_mask = layers["Enemy"] | layers["Terrain"]

## Mask for electric length determinder
var elect_length_mask = layers["Base"] | layers["Terrain"] | layers["Wall"]

var aim_mask = layers["MouseTranslation"]


## Update raycast parameters
func update_raycast_params():
	_viewport = get_viewport()
	_cam = _viewport.get_camera_3d()
	_world_3d = get_world_3d()


## Raycasft from object
func raycast(start_obj: Node3D, mask, ray_length=8):
	var start = start_obj.global_position
	var end = start - start_obj.global_transform.basis.z * ray_length
	
	var query = PhysicsRayQueryParameters3D.create(start, end, mask)
	query.collide_with_areas = true
	
	return _world_3d.direct_space_state.intersect_ray(query)


## Raycast from cam and return hit object.
func raycast_cam(mask, ray_length=200):
	var viewport: Viewport = get_viewport()
	var cam = viewport.get_camera_3d()
	var world_3d = get_world_3d()
	
	var mouse_pos = viewport.get_mouse_position()
	var start = cam.project_ray_origin(mouse_pos)
	var end = start + cam.project_ray_normal(mouse_pos) * ray_length
		
	var query = PhysicsRayQueryParameters3D.create(start, end, mask)
	query.collide_with_areas = true
	
	return world_3d.direct_space_state.intersect_ray(query)


## Returns sort of 2D cooridnate aim point for player tank
func raycast_get_aim_point() -> Vector3:
	var collided = raycast_cam(aim_mask)
	return collided["position"] if collided else Vector3(0, 0, 0)


## Returns selector tile if raycast is hit, used for Stage Editor
func raycast_selector_tile():
	var collided = raycast_cam(aim_mask)
	return collided["collider"] if collided else null


## Vector to add for calculating ray end position for each facing.
## This is used to decide whether one can move over that direction or not.
## Order is N-W-S-E
## Using 2.99 not 3 to ensure we don't get false hits.
var _movmenet_facing_offset: Array[Vector3] = [
	Vector3(0, 0, 2.99),
	Vector3(2.99, 0, 0),
	Vector3(0, 0, -2.99),
	Vector3(-2.99, 0, 0),
]


## Vector to add for calculaing ray end position for each facing.
## This is used for deciding whether to shoot or not.
## Order is N-W-S-E
var _shoot_facing_offset: Array[Vector3] = [
	Vector3(0, 0, 50),
	Vector3(50, 0, 0),
	Vector3(0, 0, -50),
	Vector3(-50, 0, 0),
]


## Raycast to given direction and return what it hit.
func _raycast_test_facing(start_obj: Node3D, facing_vector: Vector3, mask) -> Dictionary:
	var query = PhysicsRayQueryParameters3D.create(
		start_obj.position, start_obj.position + facing_vector * 10.0, mask
	)
	query.collide_with_areas = true
	
	return _world_3d.direct_space_state.intersect_ray(query)


## Raycast to test if given facing tile is movable.
## We don't consider race conditions as this rarely also happens in original game too.
#func is_movable(start_obj: Node3D, facing: int) -> bool:
#	return _raycast_test_facing(
#		start_obj, _movmenet_facing_offset[facing], movement_mask
#	).is_empty()


## Raycast to test if given facing has line-of-sight with target, ignoring walls.
func is_target_in_sight(start_obj: Node3D, mask) -> bool:
	var result = raycast(start_obj, mask)
	
	# case for this is low, but can't move this behind or will error if empty.
	if result.is_empty():
		return false
	
	# if hit stuff is obstacle, return false. Else we have target in LOS
	return not result["collider"].collision_layer & layers["Terrain"]


## Raycast from object forward and get length
func get_length(start_obj: Node3D, mask, ray_length: float) -> Array:
	var result = raycast(start_obj, mask, ray_length)
	
	if result.is_empty():
		return [null, ray_length]
	
	return [result["collider"], start_obj.global_position.distance_to(result["position"])]
