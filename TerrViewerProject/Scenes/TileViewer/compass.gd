extends Node3D

@export var cam_speed = 2.0

@onready var _pointer = $pointer
@onready var _default_transform = _pointer.transform


func reset_pointer():
	_pointer.transform = _default_transform


func rotate_pointer(amount):
	_pointer.rotate_y(amount)


#func _process(delta):
#
#	# right - left key changes cam's X axis (which actually turn in Y axis)
#	var action = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
#	if action:
#		_pointer.rotate_y(action * cam_speed * delta)
#
#	# reset view if reset_cam pressed
#	action = Input.get_action_strength("reset_cam")
#	if action:
#		_pointer.transform = _default_transform
