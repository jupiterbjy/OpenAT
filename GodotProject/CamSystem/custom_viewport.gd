extends SubViewportContainer

# implementation of
# https://www.reddit.com/r/godot/comments/ws01zp
# /comment/ikvnkek/?utm_source=share&utm_medium=web2x&context=3


@onready var _viewport: Viewport = $SubViewport


var _xy_ratio = 4.0 / 3.0
var _cam_angle: float = deg_to_rad(45.0)


func _resize():
	# get changed height.
	# we'll assume no one plays at vertical orientation (god pls)
	var new_height = size.y
	
	# render in square, but stretch to 4:3
	_viewport.size = Vector2(new_height, new_height)
	_viewport.size_2d_override = Vector2(new_height * _xy_ratio, new_height)


func _ready():
	item_rect_changed.connect(_resize)
	_resize()
