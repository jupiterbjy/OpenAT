class_name Trail extends Node3D


enum FACING {NORTH, WEST, SOUTH, EAST}
enum ACTION {TURN, FORWARD, EXPLODED}

static var _models: Array[Array] = [
	[
		preload("res://Models/Custom/trails/track_rotate_0.glb"),
		preload("res://Models/Custom/trails/track_rotate_1.glb"),
	],
	[
		preload("res://Models/Custom/trails/track_straight_0.glb"),
		preload("res://Models/Custom/trails/track_straight_1.glb"),
		preload("res://Models/Custom/trails/track_straight_2.glb"),
		preload("res://Models/Custom/trails/track_straight_3.glb"),
	],
	[
		preload("res://Models/Custom/trails/track_exploded.glb"),
	],
]
# static var _mat: ShaderMaterial = preload("res://TankEntities/base/trail_shader_mat.tres")
static var _mat: StandardMaterial3D = preload("res://Models/Custom/trails/custom_track.tres")
static var _mat2: StandardMaterial3D = preload("res://Models/Custom/trails/custom_track_2.tres")


@onready var _timer: Timer = $remove_timer


var _wait_time: float = 10.0


func pre_ready_setup(action: ACTION, facing: FACING):
	var model = _models[action].pick_random().instantiate()
	
	model.rotate_y(facing * PI / 2)
	add_child(model)
	
	model.scale = Vector3(6, 6, 6)
	
	model.get_child(0).material_override = _mat
	model.position.y -= 0.01
	
	# set longer time & size for explosion
	if action == ACTION.EXPLODED:
		model.get_child(0).material_override = _mat2
		model.scale = Vector3(1, 1, 1) * randi_range(10, 16)
		_wait_time = 180.0


func _on_remove_timer_timeout():
	queue_free()



# Called when the node enters the scene tree for the first time.
func _ready():
	_timer.start(_wait_time)
