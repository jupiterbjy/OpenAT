class_name ScoreDigit
extends Control


@onready var digit_panel: Sprite2D = $Sprite2D


# TODO: replace this with Texture2DArray
static var offsets = [
	Rect2(0, 160, 32, 32),
	Rect2(32, 160, 32, 32),
	Rect2(64, 160, 32, 32),
	Rect2(96, 160, 32, 32),
	Rect2(128, 160, 32, 32),
	Rect2(160, 160, 32, 32),
	Rect2(192, 160, 32, 32),
	Rect2(224, 160, 32, 32),
	
	Rect2(0, 192, 32, 32),
	Rect2(32, 192, 32, 32),
]


func set_digit(digit: int):
	digit_panel.region_rect = offsets[digit]
