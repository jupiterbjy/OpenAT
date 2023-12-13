class_name ObjectiveIcon
extends Control


enum {BOX, BUNKER, ENEMY, BASE}
static var _regions: Array[Rect2] = [
	# left, top, width, height
	Rect2(328, 200, 48, 48),
	Rect2(392, 200, 48, 48),
	Rect2(456, 200, 48, 48),
	Rect2(8, 264, 48, 48),
]


## Sets icon type
func set_type(type_enum):
	var objective_icon: Sprite2D = $icon

	objective_icon.region_rect = _regions[type_enum]
