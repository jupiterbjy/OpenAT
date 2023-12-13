class_name OrbitCam
extends Node3D


var cam_speed: float = -0.11

# cache references
@onready var _cam_x = $cam_x_rot_axis
@onready var cam = $cam_x_rot_axis/orbit_cam


func _process(delta):
	_cam_x.rotate_y(cam_speed * delta)
