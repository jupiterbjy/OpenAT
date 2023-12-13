extends Control


var _difficulty_names = [
	"Difficulty: Easy",
	"Difficulty: Normal",
	"Difficulty: Hard"
]


func advance_difficulty():
	Difficulty.difficulty  = (Difficulty.difficulty + 1) % 3
	$title.text = _difficulty_names[Difficulty.difficulty]


# Totally no reason to set this later
func _ready():
	$title.text = _difficulty_names[Difficulty.difficulty]


func _on_button_mouse_entered():
	MouseSignals.mouse_entered.emit()


func _on_button_pressed():
	advance_difficulty()
	MouseSignals.mouse_clicked.emit()
