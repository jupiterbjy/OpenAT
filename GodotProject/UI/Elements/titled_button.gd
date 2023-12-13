extends Control


## Using separate signal due to bug where child node is
## also considered as click area of parent button.
signal button_clicked

@export var text = "Sample Text"


# Totally no reason to set this later
func _ready():
	$title.text = text


func _on_button_mouse_entered():
	MouseSignals.mouse_entered.emit()


func _on_button_pressed():
	MouseSignals.mouse_clicked.emit()
	button_clicked.emit()
