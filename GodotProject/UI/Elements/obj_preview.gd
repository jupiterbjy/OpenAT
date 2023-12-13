extends Node3D

@export var cam_speed: float = 2.0

@onready var _turntable = $turntable

# cache cam transform & position
@onready var _cam_x = $cam_x
@onready var _x_init_trans = _cam_x.transform


var displayed_obj = null


## remove object curently on turntable
func remove_obj():
	if displayed_obj == null:
		print("[obj_preview.tscn] No object in display, can't remove!")
		return

	print("[obj_preview.tscn] Removing object %s" % displayed_obj.name)
	_turntable.remove_child(displayed_obj)


## add object on turntable
func add_obj(scene: PackedScene):
	if displayed_obj != null:
		remove_obj()
	
	displayed_obj = scene.instantiate()
	print("[obj_preview.tscn] Adding object %s" % displayed_obj.name)
	_turntable.add_child(displayed_obj)


## Set object facing direction
func set_facing(facing: int):
	displayed_obj.rotation.y = facing * PI / 2


#func _process(delta):
#	turntable.rotate_y(delta)


# func _ready():
	# var res: PackedScene = preload("res://Models/Inherited/Tanks/tank_nuc.tscn")
	# add_obj(res)


func _process(delta):
	
	# right - left key changes cam's X axis (which actually turn in Y axis)
	var action = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if action:
		_cam_x.rotate_y(action * cam_speed * delta)

	# reset view if reset_cam pressed
	action = Input.get_action_strength("reset_cam")
	if action:
		_cam_x.transform = _x_init_trans
