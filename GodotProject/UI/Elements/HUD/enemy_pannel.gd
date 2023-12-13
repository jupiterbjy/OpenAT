class_name EnemyDigit
extends Control


@onready var digit_panel: Sprite2D = $Sprite2D


static var offsets = [
	Rect2(0, 240, 16, 16),
	Rect2(16, 240, 16, 16),
	Rect2(32, 240, 16, 16),
	Rect2(48, 240, 16, 16),
	
	Rect2(64, 240, 16, 16),
	Rect2(80, 240, 16, 16),
	Rect2(96, 240, 16, 16),
	Rect2(112, 240, 16, 16),
	Rect2(128, 240, 16, 16),
	
	Rect2(144, 240, 16, 16),
]


func set_digit(digit: int):
	digit_panel.region_rect = offsets[digit]
