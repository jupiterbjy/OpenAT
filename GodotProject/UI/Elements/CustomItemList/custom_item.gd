class_name CustomItem
extends ColorRect


@onready var _label: Label = $label
var idx: int = 0


static var colors: Array[Color] = [
	Color("ffffff"),
	Color("b9d5e6"),
	Color("4c4c4c"),
]

var _is_locked: bool = false


func set_text(text: String):
	_label.text = text


func set_selected():
	color = colors[1]


func set_unselected():
	color = colors[0]


func set_locked():
	color = colors[2]
	_is_locked = true


func _on_label_gui_input(event: InputEvent):
	if event.get_action_strength("fire") and not _is_locked:
		MouseSignals.mouse_clicked.emit()
		set_selected()
		UISignals.user_selected.emit(idx)


func _on_label_mouse_entered():
	MouseSignals.mouse_entered.emit()
