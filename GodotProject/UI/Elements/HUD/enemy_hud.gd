class_name EmemyHUD
extends Control


@onready var digits: Array[EnemyDigit] = [
	$HBoxContainer/enemy_pannel,
	$HBoxContainer/enemy_pannel2
]


var num: int


func update_digits():
	# if num is larger than 100, just show 99
	var target = num if num < 100 else 99
	
	digits[0].set_digit(num / 10)
	digits[1].set_digit(num % 10)


func set_initial_val(val: int):
	num = val
	update_digits()


func count_down():
	num -= 1
	update_digits()


func _ready():
	var level: Level = SceneSignals.current_scene.get_child(0)
	set_initial_val(level.respawns.enemy_count)
	UISignals.enemy_destroyed.connect(count_down)
