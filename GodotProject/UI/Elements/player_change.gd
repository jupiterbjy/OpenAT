extends Control


@onready var label: Label = $change_button/NinePatchRect/VBoxContainer/Label


func update_player_name():
	label.text = "Welcome, " + UserState.user_name


func _ready():
	update_player_name()


func _on_change_button_pressed():
	UISignals.request_ui.emit(UIEnum.SELECT_USER)
	MouseSignals.mouse_clicked.emit()


func _on_change_button_mouse_entered():
	MouseSignals.mouse_entered.emit()
