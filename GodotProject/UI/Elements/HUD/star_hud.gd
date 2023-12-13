extends Control


@onready var life_icons = [
	$HBoxContainer/star,
	$HBoxContainer/star2,
	$HBoxContainer/star3,
]


var stars = 0


func add_star():
	if stars < 3:
		life_icons[stars].show()
		stars += 1


func _ready():
	UISignals.player_got_star.connect(add_star)
	for icon in life_icons:
		icon.hide()
