extends Control


func _on_ok_button_button_clicked():
	UISignals.request_ui.emit(UIEnum.PAUSE)
