extends Control


var switching_target = UIEnum.MAIN_MENU


func _on_ok_button_button_clicked():
	GlobalState.save_json()
	UISignals.request_ui.emit(switching_target)
