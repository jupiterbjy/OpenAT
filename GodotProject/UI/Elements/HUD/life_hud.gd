extends Control


@onready var life_icons = [
	$HBoxContainer/life/full,
	$HBoxContainer/life2/full,
	$HBoxContainer/life3/full,
]


var lifes = 3


func set_starting_life(amount: int):
	lifes = amount


func drop_life():
	if lifes < 1:
		return
	
	lifes -= 1
	life_icons[lifes].hide()


func _ready():
	UISignals.player_life_lost.connect(drop_life)
