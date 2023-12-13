extends Control


var _weapon_rects: Array[Rect2] = [
	# cannon
	Rect2(112, 48, 48, 48),
	
	# gattling
	Rect2(208, 96, 48, 48),
	
	# rocket
	Rect2(112, 96, 48, 48),
	
	# electric
	Rect2(64, 96, 48, 48),
	
	# fire
	Rect2(160, 96, 48, 48),
	
	# shock
	Rect2(16, 96, 48, 48),
]



func load_weapon_type(type: int):
	$weapon_icon.region_rect = _weapon_rects[type]


# Called when the node enters the scene tree for the first time.
func _ready():
	load_weapon_type(UserState.selected_weapon_idx)
