extends TextureButton


func _on_pressed():
	# open workshop
	UISignals.request_ui.emit(UIEnum.WORKSHOP, UIEnum.MAIN_MENU)
	MouseSignals.mouse_clicked.emit()


func _on_mouse_entered():
	MouseSignals.mouse_entered.emit()
