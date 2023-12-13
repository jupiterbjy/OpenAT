class_name ScoreHUD
extends Control


@onready var digits: Array[ScoreDigit] = [
	$HBoxContainer/score_digit,
	$HBoxContainer/score_digit2,
	$HBoxContainer/score_digit3,
	$HBoxContainer/score_digit4,
	$HBoxContainer/score_digit5,
	$HBoxContainer/score_digit6,
	$HBoxContainer/score_digit7,
	$HBoxContainer/score_digit8,
]


var num: int


func update_digits():
	# if num is larger than 100000000, just show 99999999
	var target = num if num < 100000000 else 99999999

	var num_str = str(num).pad_zeros(8)

	for idx in range(8):
		digits[idx].set_digit(int(num_str[idx]))


func set_initial_val(val: int):
	num = val
	update_digits()


func add_score(val: int):
	num += val
	update_digits()


func _ready():
	UISignals.add_score.connect(add_score)
