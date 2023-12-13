extends Node3D


func _adjust_offset():
	var size = MapJsonLoader.current_loaded["size"]
	position.x = (1 - size[0]) / 2
	position.z = (1 - size[0]) / 2


func _ready():
	_adjust_offset()
